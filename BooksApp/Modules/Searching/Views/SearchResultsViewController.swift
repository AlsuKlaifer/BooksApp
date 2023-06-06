//
//  SearchResultsViewController.swift
//  BooksApp
//
//  Created by Alsu Faizova on 05.06.2023.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidTapItem(_ book: Book)
}

class SearchResultsViewController: UIViewController {
    
    var data: [Book] = []
    // Dependencies
//    private let output: SearchViewOutput
//
//    // MARK: - Initialization
//
//    init(presenter: SearchViewOutput) {
//        output = presenter
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    public weak var delegate: SearchResultsViewControllerDelegate?
    
    public let searchResultsTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.register(SearchCell.self, forCellReuseIdentifier: SearchCell.reuseIdentifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        output.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultsTable)
        
        searchResultsTable.delegate = self
        searchResultsTable.dataSource = self
        searchResultsTable.keyboardDismissMode = .onDrag
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsTable.frame = view.bounds
    }
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
//        return output.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.reuseIdentifier, for: indexPath) as? SearchCell else { return UITableViewCell() }
        cell.configureCell(with: data[indexPath.row])
//        cell.favoriteButtonAction = { [weak self] in
//            self?.output.updateFavorite(item: books[indexPath.row])
//        }
//        cell.isFavorite = self.output.getFavorite(item: books[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        delegate?.searchResultsViewControllerDidTapItem(output.data[indexPath.row])
    }
}

//extension SearchResultsViewController: SearchViewInput {
//    func reloadData() {
//        searchResultsTable.reloadData()
//    }
//}
