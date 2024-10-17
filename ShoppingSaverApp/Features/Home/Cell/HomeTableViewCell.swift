//
//  HomeTableViewCell.swift
//  ShoppingSaverApp
//
//  Created by furkan sakız on 14.10.2024.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    /// List Label
    private var shoppingListLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    /// Subtitle Label
    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        return label
    }()

    /// Mark Button
    private var markButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        let markedImage = UIImage(systemName: "checkmark.circle.fill", withConfiguration: config)
        button.setImage(markedImage, for: .normal)
        button.tintColor = .lightGray
        return button
    }()

    /// Background Container View
    private lazy var backgroundContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setup Layout
    private func setupLayout() {
        contentView.addSubview(backgroundContainerView)
        backgroundContainerView.addSubview(shoppingListLabel)
        backgroundContainerView.addSubview(subtitleLabel)
        backgroundContainerView.addSubview(markButton)
    }
    // MARK: - UI
    private func setupConstraints() {
        backgroundContainerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.top.equalToSuperview().inset(5)
        }
        
        shoppingListLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview().offset(-8)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(shoppingListLabel.snp.leading)
            make.top.equalTo(shoppingListLabel.snp.bottom).offset(2)
        }
        
        markButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
    // MARK: - Configure
    func configure(with text: String, itemCount: Int ,isMarked: Bool) {
        shoppingListLabel.text = text
        subtitleLabel.text = "\(itemCount) ürün"
        markButton.tintColor = isMarked ? .systemPink : .white
    }
}
