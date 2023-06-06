//
//  SearchViewController.swift
//  BooksApp
//
//  Created by Alsu Faizova on 05.06.2023.
//

import UIKit
import ProgressHUD

enum Filter: String {
    case byPartial = "Partial"
    case byFull = "Full"
    case byFreeEbooks = "Free-ebooks"
    case byPaidEbooks = "Paid-ebooks"
    case byEbooks = "Ebooks"
}

enum Sort: String {
    case byRelevance = "Relevance"
    case byNewest = "Newest"
}

final class SearchViewController: UIViewController {

    // Dependencies
    private let output: SearchViewOutput

    // MARK: - Initialization

    init(presenter: SearchViewOutput) {
        output = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let items = ["Books", "Magazines"]
    private var filter: String?
    private var sort: String?
    private var type = 0
    private var startIndex = 0

    private lazy var spinnerFooter: UIView = {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }()

    private let searchTable: UITableView = {
        let table = UITableView()
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.register(SearchCell.self, forCellReuseIdentifier: SearchCell.reuseIdentifier)
        return table
    }()

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: SearchResultsViewController())
        searchController.searchBar.tintColor = .orange
        searchController.searchBar.placeholder = "Title, Author"
        return searchController
    }()

    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: self.items)
        segmentedControl.frame.size.height = 40.0
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = UIColor.yellow
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(searchTable)
        searchTable.delegate = self
        searchTable.dataSource = self
        searchTable.keyboardDismissMode = .onDrag
        searchController.searchResultsUpdater = self
        searchTable.tableHeaderView = segmentedControl
        ProgressHUD.show()
        output.getBooks(type: items[type], orderBy: sort, filter: filter, startIndex: startIndex) {
            ProgressHUD.dismiss()
        }
        output.viewDidLoad()
        // Setting navigation bar
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                image: UIImage(systemName: "line.3.horizontal.decrease.circle"),
                style: .done,
                target: self,
                action: #selector(filterAction)
            ),
            UIBarButtonItem(
                image: UIImage(systemName: "arrow.up.arrow.down"),
                style: .done,
                target: self,
                action: #selector(sortAction)
            )
        ]
        navigationItem.titleView?.tintColor = .label
        navigationItem.searchController = searchController
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchTable.frame = view.bounds
    }

    @objc func segmentedValueChanged(_ sender: UISegmentedControl) {
        type = segmentedControl.selectedSegmentIndex
        startIndex = 0
        filter = nil
        ProgressHUD.show()
        output.getBooks(type: items[type], orderBy: sort, filter: filter, startIndex: startIndex) {
            ProgressHUD.dismiss()
        }
    }

    @objc func sortAction() {
        let alert = UIAlertController(title: "Sort by", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Sort.byRelevance.rawValue, style: .default, handler: alertSortAction))
        alert.addAction(UIAlertAction(title: Sort.byNewest.rawValue, style: .default, handler: alertSortAction))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    @objc func filterAction() {
        let alert = UIAlertController(title: "Filter by", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Filter.byPartial.rawValue, style: .default, handler: alertFilterAction))
        alert.addAction(UIAlertAction(title: Filter.byFull.rawValue, style: .default, handler: alertFilterAction))
        alert.addAction(UIAlertAction(title: Filter.byFreeEbooks.rawValue, style: .default, handler: alertFilterAction))
        alert.addAction(UIAlertAction(title: Filter.byPaidEbooks.rawValue, style: .default, handler: alertFilterAction))
        alert.addAction(UIAlertAction(title: Filter.byEbooks.rawValue, style: .default, handler: alertFilterAction))
        alert.addAction(UIAlertAction(title: "Delete filters", style: .destructive, handler: alertFilterAction))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    func alertSortAction(_ action: UIAlertAction) {
        sort = action.title
        startIndex = 0
        ProgressHUD.show()
        output.getBooks(type: items[type], orderBy: sort, filter: filter, startIndex: startIndex) {
            ProgressHUD.dismiss()
        }
    }

    func alertFilterAction(_ action: UIAlertAction) {
        startIndex = 0
        if action.style == .destructive {
            filter = nil
            ProgressHUD.show()
            output.getBooks(type: items[type], orderBy: sort, filter: filter, startIndex: startIndex) {
                ProgressHUD.dismiss()
            }
        } else {
            filter = action.title
        }
        guard let filterAction = filter else { return }
        ProgressHUD.show()
        output.getBooks(type: items[type], orderBy: sort, filter: "&filter=\(filterAction)", startIndex: startIndex) {
            ProgressHUD.dismiss()
        }
        filter = "&filter=\(action.title ?? "paid-ebooks")"
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.reuseIdentifier, for: indexPath) as? SearchCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        let book = output.data[indexPath.row]
        cell.configureCell(with: book)
        cell.favoriteButtonAction = { [weak self] in
            self?.output.updateFavorite(book: book)
        }
        cell.isFavorite = self.output.getFavorite(book: book)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        output.didSelectItem(book: output.data[indexPath.row])
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == output.data.count - 1 {
            self.searchTable.tableFooterView = spinnerFooter
            startIndex += 10
            output.willDisplay(type: items[type], orderBy: sort, filter: filter, startIndex: startIndex) {
                DispatchQueue.main.async {
                    self.searchTable.tableFooterView = nil
                }
            }
        }
    }
}

extension SearchViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate {
    func searchResultsViewControllerDidTapItem(_ book: Book) {
        DispatchQueue.main.async { [weak self] in
            self?.output.didSelectItem(book: book)
        }
    }

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
            !query.trimmingCharacters(in: .whitespaces).isEmpty,
            let resultController = searchController.searchResultsController as? SearchResultsViewController else { return }
        ProgressHUD.show()
        resultController.delegate = self

        output.search(with: query, type: items[type], orderBy: sort, filter: filter) { books in
            DispatchQueue.main.async {
                ProgressHUD.dismiss()
                resultController.books = books
                resultController.searchResultsTable.reloadData()
            }
        }
    }
}

extension SearchViewController: SearchViewInput {
    func reloadData() {
        searchTable.reloadData()
    }
}
