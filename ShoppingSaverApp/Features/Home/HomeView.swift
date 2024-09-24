//
//  HomeView.swift
//  ShoppingSaverApp
//
//  Created by furkan sakız on 8.09.2024.
//
//

import SnapKit
import UIKit

final class HomeView: BaseView<HomeViewController>, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    let shoppingList = ["Elma", "Armut", "Muz", "Kivi", "Çilek", "Portakal", "Mandalina", "Karpuz", "Kavun", "Üzüm"]

    override func setupView() {
        super.setupView()
        setupLayout()
        setupConstraints()
    }

    // sample method to setup layout

    /// app title
    private lazy var appTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    /// shopping list title
    private lazy var shoppingListLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    /// + Butonu
    private lazy var addButton: UIButton = {
        let button = UIButton()
        return button
    }()

    /// Recommendations CollectionView
    private lazy var recommendationsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let screenSize = UIScreen.main.bounds.size
        let itemWidth = screenSize.width * 0.8 // ekranın genişliğinin %80'i
        let itemHeight = screenSize.height * 0.25 // ekranın yüksekliğinin %25'i
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 10

        let inset = (screenSize.width - itemWidth) / 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset / 2, bottom: 0, right: inset)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "recommendationCell")
        return collectionView
    }()

    /// ShoppingList TableView
    private lazy var shoppingListTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "shoppingListCell")
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 10
        tableView.layer.masksToBounds = true
        return tableView
    }()

    // MARK: - Setup Layout

    private func setupLayout() {    
        addSubview(appTitleLabel)
        addSubview(recommendationsCollectionView)
        addSubview(shoppingListLabel)
        addSubview(addButton)
        addSubview(shoppingListTableView)

        appTitleLabel.text = "Sipariş Arkadaşım"
        appTitleLabel.font = UIFont.systemFont(ofSize: 28, weight: .heavy)

        shoppingListLabel.text = "Sipariş Listelerim"
        shoppingListLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        shoppingListLabel.textColor = .lightGray

        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold)
        let boldButton = UIImage(systemName: "plus", withConfiguration: config)
        addButton.setImage(boldButton, for: .normal)
        addButton.tintColor = .lightGray
    }

    // MARK: - UI

    func setupConstraints() {
        appTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(40)
        }

        recommendationsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(appTitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }

        shoppingListLabel.snp.makeConstraints { make in
            make.top.equalTo(recommendationsCollectionView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(40)
        }

        addButton.snp.makeConstraints { make in
            make.height.width.equalTo(40)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(recommendationsCollectionView.snp.bottom).offset(10)
        }

        shoppingListTableView.snp.makeConstraints { make in
            make.top.equalTo(shoppingListLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }

    // MARK: - UICollectionViewDataSource & UICollectionViewDelegate metodları

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendationCell", for: indexPath)
        cell.backgroundColor = .systemGray4
        return cell
    }

    // MARK: - UITableViewDataSource & UITableViewDelegate metodları

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingListCell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        cell.selectionStyle = .none

        /// checkbox button
        let checkboxButton = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        let uncheckedImage = UIImage(systemName: "square", withConfiguration: config)
        checkboxButton.setImage(uncheckedImage, for: .normal)
        checkboxButton.tintColor = .gray
        checkboxButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)

        cell.accessoryView = checkboxButton

        return cell
    }
}

#Preview {
    HomeViewController()
}
