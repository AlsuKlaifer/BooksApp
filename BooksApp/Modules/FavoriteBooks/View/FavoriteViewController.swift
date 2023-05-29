//
//  FavoriteViewController.swift
//  BooksApp
//
//  Created by Alsu Faizova on 13.04.2023.
//

import UIKit

final class FavoriteViewController: UIViewController {

    // Dependencies
    private let output: FavoriteViewOutput

    // MARK: - Initialization

    init(presenter: FavoriteViewOutput) {
        self.output = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Outlets

    private lazy var collectionView: UICollectionView = {
        let collectionView = createCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Favorite"
        setupView()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        output.viewDidLoad()
    }

    func setupView() {
        collectionView.register(
            PopularCollectionViewCell.self,
            forCellWithReuseIdentifier: PopularCollectionViewCell.reuseIdentifier)
        collectionView.register(
            ReadCollectionViewCell.self,
            forCellWithReuseIdentifier: ReadCollectionViewCell.reuseIdentifier)
    }
}

// MARK: - Create Coolection View

extension FavoriteViewController {
    private func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        return collectionView
    }

    // MARK: - Setup Layout

    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self else { fatalError("Self is nil") }
            switch self.output.data[sectionIndex] {
            case .read:
                return self.createReadSection()
            case .favorite:
                return self.createPopularSection()
            }
        }
        return layout
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

    private func createReadSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(0.3),
            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.1),
                heightDimension: .fractionalHeight(0.25)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = .init(top: 10, leading: 10, bottom: 20, trailing: 0)
        section.interGroupSpacing = -50 
        return section
    }
}

extension FavoriteViewController {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = self.output.data[indexPath.section]
        switch section {
        case .read:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ReadCollectionViewCell.reuseIdentifier,
                for: indexPath) as? ReadCollectionViewCell
                else { return UICollectionViewCell() }
            cell.configureCell(with: section.items[indexPath.row])
            return cell

        case .favorite:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PopularCollectionViewCell.reuseIdentifier,
                for: indexPath) as? PopularCollectionViewCell
                else { return UICollectionViewCell() }
            cell.configureCellBookModel(with: section.items[indexPath.row])
            return cell
        }
    }
}
extension FavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = output.data[indexPath.section]
        let item = section.items[indexPath.item]
        output.didSelectItem(item: item)
    }
}

extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.output.data[section].items.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
}

// MARK: - Set Constraints

extension FavoriteViewController {

    private func setConstraints() {

        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
}

extension FavoriteViewController: FavoriteViewInput {
    func reloadData() {
        collectionView.reloadData()
    }
}

enum Section {
    case read([BookModel])
    case favorite([BookModel])

    var items: [BookModel] {
        switch self {
        case .read(let items),
             .favorite(let items):
            return items
        }
    }
}
