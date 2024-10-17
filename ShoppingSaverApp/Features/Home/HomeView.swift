//
//  HomeView.swift
//  ShoppingSaverApp
//
//  Created by furkan sakız on 8.09.2024.
//
//

import SnapKit
import UIKit

final class HomeView: BaseView<HomeViewController> {
    let shoppingList = ["Market Listem", "Teknoloji dükkanından alınacaklar", "Kısır için alınacaklar", "Evin eksikleri", "Annemin aldıracakları", "Market Listem", "Market Listem", "Market Listem"]

    override func setupView() {
        super.setupView()
        setupLayout()
        setupConstraints()
    }

    // sample method to setup layout

    /// ScrollView
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.layoutIfNeeded()
        return scrollView
    }()

    /// ContentView
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()

    /// Header label
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Merhaba,"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        return label
    }()

    /// subtitle label
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Furkan Sakız"
        label.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        label.textColor = .systemPink
        return label
    }()

    /// search bar
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Ara..."
        return searchBar
    }()

    /// recommendations title
    private lazy var recommendationsLabel: UILabel = {
        let label = UILabel()
        label.text = "Önerilen Tarifler"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    /// shopping list title
    private lazy var shoppingListLabel: UILabel = {
        let label = UILabel()
        label.text = "Sipariş Listelerim"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    /// Oluştur Butonu
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Oluştur", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
//        button.setTitleColor(.systemPink, for: .normal)
        button.tintColor = .systemPink
        return button
    }()

    /// Recommendations CollectionView
    private lazy var recommendationsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let screenSize = UIScreen.main.bounds.size
        let itemWidth = screenSize.width * 0.40 // ekranın genişliğinin %40'i
        let itemHeight = itemWidth * 1.25 // item genişliğinin 1.5 katı
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 10

        let inset = (screenSize.width - itemWidth) / 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: inset)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(RecommendationsCollectionViewCell.self, forCellWithReuseIdentifier: "RecommendationsCollectionViewCell")
        return collectionView
    }()

    /// ShoppingList TableView
    private lazy var shoppingListTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        tableView.separatorStyle = .none
        return tableView
    }()

    // MARK: - Setup Layout

    private func setupLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(headerLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(searchBar)
        contentView.addSubview(recommendationsLabel)
        contentView.addSubview(recommendationsCollectionView)
        contentView.addSubview(shoppingListLabel)
        contentView.addSubview(addButton)
        contentView.addSubview(shoppingListTableView)
    }

    // MARK: - UI

    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.bottom.equalTo(shoppingListTableView.snp.bottom).offset(20)
        }

        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.leading.equalToSuperview().offset(20)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(40)
        }

        searchBar.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        recommendationsLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }

        recommendationsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recommendationsLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }

        shoppingListLabel.snp.makeConstraints { make in
            make.top.equalTo(recommendationsCollectionView.snp.bottom)
            make.leading.equalTo(shoppingListTableView.snp.leading)
            make.height.equalTo(40)
        }

        addButton.snp.makeConstraints { make in
//            make.height.width.equalTo(40)
            make.trailing.equalTo(shoppingListTableView.snp.trailing)
            make.centerY.equalTo(shoppingListLabel.snp.centerY)
        }

        shoppingListTableView.snp.makeConstraints { make in
            make.top.equalTo(shoppingListLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(calculateTableViewHeight()) // Dynamic TableView Height
        }
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate metodları

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendationsCollectionViewCell", for: indexPath) as? RecommendationsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let recipeImage = UIImage(systemName: "recommendationPhoto")
        let recipeTitle = "\(indexPath.item + 1) şiş köfte"
        cell.configure(image: "recommendationPhoto")
        cell.contentView.frame = cell.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20))
        return cell
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate metodları

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        let inset: CGFloat = 10 /// tableview satırları arası boşluk
        let margins = UIEdgeInsets(top: inset, left: 0, bottom: inset, right: 0)
        cell.contentView.frame.inset(by: margins)
        cell.selectionStyle = .none
        
        let shoppingListItem = shoppingList[indexPath.row]
        let isMarked = indexPath.row % 4 == 0
        cell.configure(with: shoppingListItem, itemCount: indexPath.row ,isMarked: isMarked)
        return cell
    }
    
    /// Tableview scroll üzerinde olduğundan dolayı boyut verilmeden aralarda boşluk bırakılamamaktadır.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    private func calculateTableViewHeight() -> CGFloat {
        let headerLabelHeight: CGFloat = 10 + 16 // üst boşluk + label yüksekliği
        let subtitleLabelHeight: CGFloat = 2 + 40 // üst boşluk + label yüksekliği
        let searchBarHeight: CGFloat = 10 + 56 // üst boşluk + searchBar varsayılan yüksekliği
        let recommendationsLabelHeight: CGFloat = 20 + 20 // üst boşluk + label yüksekliği
        let recommendationsCollectionViewHeight: CGFloat = 10 + 200 // üst boşluk + collectionView yüksekliği
        let shoppingListLabelHeight: CGFloat = 10 + 40 + 10 // üst boşluk + label yüksekliği + alt boşluk

        let contentsHeight = headerLabelHeight + subtitleLabelHeight + searchBarHeight +
            recommendationsLabelHeight + recommendationsCollectionViewHeight +
            shoppingListLabelHeight

        let screenHeight = UIScreen.main.bounds.height
        let tableViewHeight = screenHeight - contentsHeight

        let estimatedRowHeight: CGFloat = 80
        let totalTableViewHeight = estimatedRowHeight * CGFloat(shoppingList.count)
        return max(totalTableViewHeight, tableViewHeight)
    }
}

#Preview {
    HomeViewController()
}
