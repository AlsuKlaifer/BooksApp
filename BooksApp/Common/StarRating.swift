//
//  StarRatingView.swift
//  Star Rating View
//
//  Created by Alsu Faizova on 16.05.2023.
//

import UIKit

enum StarType: String {
    
    case emptyStar = "star", halfStar = "star.leadinghalf.filled", filledStar = "star.fill"
    
    var toImage: UIImage {
        let config = UIImage.SymbolConfiguration(pointSize: .zero, weight: .heavy, scale: .large)
        return UIImage(systemName: self.rawValue, withConfiguration: config)!.withRenderingMode(.alwaysTemplate)
    }
}

public class StarRatingView: UIView {
    
    // MARK: - Properties
    
    private var starsCount: Int = 5
    private var rating: Double = 0
    
    private var starRatingStackView: UIStackView!
        
    // MARK: - Initializers
    
    convenience init(frame: CGRect, starsCount: Int = 5, rating: Double = 0.0) {
        self.init(frame: frame)
        self.starsCount = starsCount
        self.rating = rating
    }
    
    convenience init(starsCount: Int = 5, rating: Double = 0.0) {
        self.init()
        self.starsCount = starsCount
        self.rating = rating
    }
    
    // MARK: - Lifecycle
    
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        setupViews()
    }
}

// MARK: - Methods
extension StarRatingView {
    
    // MARK: Setup View

    private func setupViews() {
        
        let starRatingStackView = createStarRatingStackView()
        addSubview(starRatingStackView)
        starRatingStackView.translatesAutoresizingMaskIntoConstraints = false
        starRatingStackView.tintColor = .systemYellow
        
        NSLayoutConstraint.activate([
            starRatingStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            starRatingStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            starRatingStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            starRatingStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -130)
        ])
        
        self.starRatingStackView = starRatingStackView
    }
    
    public func updateView(starsCount: Int? = nil, rating: Double) {
            
        self.rating = rating
        
        if let starsCount = starsCount {
            self.starsCount = starsCount
            starRatingStackView.removeFromSuperview()
            setupViews()
            return
        }
        
        if starRatingStackView?.arrangedSubviews.count != .zero {
            updateStarImageViews()
        }
    }
    
    private func updateStarImageViews() {
        
        var starTyper = StarTypeIterator(rating: rating)
        
        starRatingStackView.arrangedSubviews.forEach { ($0 as! UIImageView).image = starTyper.next().toImage }
    }
    
    private func createStarRatingStackView() -> UIStackView {
        
        let stackView = UIStackView(arrangedSubviews: createStarImageViews())
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
    }
    
    private func createStarImageViews() -> [UIImageView] {
        
        var starViews: [UIImageView] = []
        var starTyper = StarTypeIterator(rating: rating)
        
        (0..<starsCount).forEach { [weak self] index in
            
            guard let strongSelf = self else { return }
            
            starViews.append(strongSelf.createStarImageView(tag: (index + 1), using: starTyper.next()))
        }
        
        return starViews
    }
    
    private func createStarImageView(tag: Int, using starType: StarType) -> UIImageView {
        
        let starImageView = UIImageView(frame: .init(x: 0, y: 0, width: 8, height: 8))
        starImageView.contentMode = .scaleAspectFit
        starImageView.image = starType.toImage
        
        return starImageView
    }
}
