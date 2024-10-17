//
//  RecommendationsCollectionViewCell.swift
//  ShoppingSaverApp
//
//  Created by furkan sakız on 14.10.2024.
//

import SnapKit
import UIKit

class RecommendationsCollectionViewCell: UICollectionViewCell {
    /// Recipe Image
    private lazy var recipeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Layout

    private func setupLayout() {
        contentView.addSubview(recipeImage)
    }

    // MARK: - UI

    private func setupConstraints() {
        
        recipeImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.snp.height)
        }
    }

    // MARK: - Configure

    func configure(image recipeImage: String) {
        self.recipeImage.image = UIImage(named: recipeImage)
    }
}
