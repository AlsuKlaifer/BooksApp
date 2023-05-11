//
//  BooksViewController.swift
//  BooksApp
//
//  Created by Alsu Faizova on 13.04.2023.
//

import UIKit

final class BooksViewController: UIViewController {

    private let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.tintColor = .orange
        searchController.searchBar.placeholder = "Search books"
        return searchController
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = createCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    var dataSource: UICollectionViewDiffableDataSource<ListSection, ListItem>?

    var sections: [ListSection] = []

    // Dependencies
    private let presenter: BooksViewOutput

    // MARK: - Initialization

    init(presenter: BooksViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        presenter.viewDidLoad()
        setupView()
        createDataSource()
        reloadData()
        setConstraints()

        navigationItem.searchController = searchController
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
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
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
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
        }
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
            heightDimension: .fractionalHeight(120))
        )
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
        dataSource = UICollectionViewDiffableDataSource<ListSection, ListItem>(
            collectionView: collectionView) { collectionView, indexPath, item -> UICollectionViewCell? in
            switch self.sections[indexPath.section] {
            case .new:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "NewCollectionViewCell",
                    for: indexPath) as? NewCollectionViewCell
                    else { return UICollectionViewCell() }
                cell.configureCell(with: item)
                return cell

            case .popular:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "PopularCollectionViewCell",
                    for: indexPath) as? PopularCollectionViewCell
                    else { return UICollectionViewCell() }
                cell.configureCell(with: item)
                return cell

            case .category:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "CategoryCollectionViewCell",
                    for: indexPath) as? CategoryCollectionViewCell
                    else { return UICollectionViewCell() }
                cell.configureCell(with: item)
                return cell
            }
        }
    }

    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<ListSection, ListItem>()
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

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
}

extension BooksViewController: BooksViewInput {
    func getListSections(sections: [ListSection]) {
        self.sections = sections
        self.collectionView.reloadData()
        self.reloadData()
    }
}
