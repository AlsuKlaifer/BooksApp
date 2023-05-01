//
//  BooksViewController.swift
//  BooksApp
//
//  Created by Alsu Faizova on 13.04.2023.
//

import UIKit

final class BooksViewController: UIViewController {

    private let sections = MockData.shared.data

    private lazy var collectionView: UICollectionView = {
        let collectionView = createCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Books"

        setDelegates()
        setupView()
        setConstraints()
    }

    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
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

// MARK: - Create Layout
extension BooksViewController {

    private func createCollectionView() -> UICollectionView {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: { [weak self] sectionIndex, _ in
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
            },
            configuration: configuration
        )
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }

    private func createNewSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .fractionalHeight(0.2)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 5
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
        section.contentInsets = .init(top: 30, leading: 10, bottom: 30, trailing: 0)
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

// MARK: - UICollectionViewDelegate

extension BooksViewController: UICollectionViewDelegate { }

// MARK: - UICollectionViewDataSource

extension BooksViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        switch sections[indexPath.section] {
        case .new(let new):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "NewCollectionViewCell",
                for: indexPath) as? NewCollectionViewCell
                else {
                return UICollectionViewCell()
            }
            let newBook = new[indexPath.row]
            cell.configureCell(name: newBook.title, imageName: newBook.image)
            return cell

        case .popular(let popular):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PopularCollectionViewCell",
                for: indexPath) as? PopularCollectionViewCell
                else {
                return UICollectionViewCell()
            }
            let popularBook = popular[indexPath.row]
            cell.configureCell(popularName: popularBook.title, imageName: popularBook.image)
            return cell

        case .category(let category):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "CategoryCollectionViewCell",
                for: indexPath) as? CategoryCollectionViewCell
                else {
                return UICollectionViewCell()
            }
            let categoty = category[indexPath.row]
            cell.configureCell(categoryName: categoty.title)
            return cell
        }
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
