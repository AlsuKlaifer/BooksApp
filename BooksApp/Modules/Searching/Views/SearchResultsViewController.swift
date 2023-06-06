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

    public var books: [Book] = []
    
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
        books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.reuseIdentifier, for: indexPath) as? SearchCell else { return UITableViewCell() }
        cell.configureCell(with: books[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.searchResultsViewControllerDidTapItem(books[indexPath.row])
    }
}

extension SearchResultsViewController: SearchViewInput {
    func reloadData() {
        searchResultsTable.reloadData()
    }
}
