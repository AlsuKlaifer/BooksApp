//
//  BooksViewController.swift
//  BooksApp
//
//  Created by Alsu Faizova on 13.04.2023.
//

import UIKit

final class BooksViewController: UIViewController {

    private let sections = MockData.shared.data

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.autocorrectionType = .no
        searchBar.placeholder = "Search books"
        searchBar.autocapitalizationType = .none
        searchBar.searchTextField.layer.cornerRadius = 20
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = .clear
        searchBar.searchTextField.tokenBackgroundColor = .white
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.clipsToBounds = true
        searchBar.searchTextField.layer.borderWidth = 1
        searchBar.searchTextField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        searchBar.searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.searchTextField.heightAnchor.constraint(equalToConstant: 45),
            searchBar.searchTextField.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 10),
            searchBar.searchTextField.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -10),
            searchBar.searchTextField.topAnchor.constraint(equalTo: searchBar.topAnchor, constant: 0)
        ])
        return searchBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = createCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    var dataSource: UICollectionViewDiffableDataSource<ListSection, Book>?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupView()
        createDataSource()
        reloadData()
        setConstraints()
    }

    func setupView() {
        view.addSubview(collectionView)
        collectionView.register(
            NewCollectionViewCell.self,
            forCellWithReuseIdentifier: "NewCollectionViewCell")
        collectionView.register(
            PopularCollectionViewCell.self,
            forCellWithReuseIdentifier: "PopularCollectionViewCell")
        collectionView.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    }
}

// MARK: - Create Coolection View

extension BooksViewController {

    private func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        return collectionView
    }

    // MARK: - Setup Layout
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            guard let self else { fatalError("Self is nil") }
            let section = self.sections[sectionIndex]
            switch section {
            case .new:
                return self.createNewSection()
            case .category:
                return self.createCategorySection()
            case .popular:
                return self.createPopularSection()
            }
        })
        return layout
    }

    private func createNewSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .fractionalHeight(0.22)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 10
        return section
    }

    private func createCategorySection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(0.25),
            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.2),
                heightDimension: .fractionalHeight(0.05)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 30, leading: 10, bottom: 20, trailing: 0)
        return section
    }

    private func createPopularSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(120)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(1)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        return section
    }
}

// MARK: - Create CollectionView Diffable Data Source

extension BooksViewController {
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<ListSection, Book>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, book -> UICollectionViewCell? in
                switch self.sections[indexPath.section] {
                case .new:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: "NewCollectionViewCell",
                        for: indexPath) as? NewCollectionViewCell
                        else { return UICollectionViewCell() }
                    cell.configureCell(with: book)
                    return cell

                case .popular:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: "PopularCollectionViewCell",
                        for: indexPath) as? PopularCollectionViewCell
                        else { return UICollectionViewCell() }
                    cell.configureCell(with: book)
                    return cell

                case .category(let category):
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: "CategoryCollectionViewCell",
                        for: indexPath) as? CategoryCollectionViewCell
                        else { return UICollectionViewCell() }
                    let categoty = category[indexPath.row]
                    cell.configureCell(categoryName: categoty.title)
                    return cell
                }
            }
        )
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<ListSection, Book>()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource?.apply(snapshot)
    }
}

// MARK: - Set Constraints

extension BooksViewController {

    private func setConstraints() {
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 45),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
}

// MARK: - SwiftUI

import SwiftUI

struct BooksProvider: PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }

    struct ContainterView: UIViewControllerRepresentable {
        func updateUIViewController(_ uiViewController: BooksViewController, context: Context) { }

        let booksVC = BooksViewController()
        func makeUIViewController(
            context: UIViewControllerRepresentableContext<BooksProvider.ContainterView>
        ) -> BooksViewController {
            return booksVC
        }
    }
}
