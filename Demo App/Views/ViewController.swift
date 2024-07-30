//
//  ViewController.swift
//  Demo App
//
//  Created by Subodh Jondhale on 30/07/24.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    // MARK: - Views

    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(CarouselTableViewCell.self, forCellReuseIdentifier: CarouselTableViewCell.identifier)
        tv.register(ListItemCell.self, forCellReuseIdentifier: ListItemCell.identifier)
        tv.register(SearchBarTableViewCell.self, forCellReuseIdentifier: SearchBarTableViewCell.identifier)
        tv.dataSource = self
        tv.delegate = self
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        return tv
    }()

    private lazy var carouselHeight: CGFloat = {
        let width = UIScreen.main.bounds.width - 40
        let height = width * 0.56
        return height + 50
    }()

    lazy var carouselImages: [UIImage] = {
        return viewModel.pages.compactMap { UIImage(named: $0.image) }
    }()

    lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        let image = UIImage(systemName: "ellipsis", withConfiguration: config)
        let buttonImage = image?.withRenderingMode(.alwaysTemplate).withTintColor(.white)
        button.setImage(buttonImage, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(displayStats), for: .touchUpInside)
        return button
    }()

    // MARK: - Private Properties

    private var currentItems: [ListItem] = []
    private var viewModel = ViewModel()
    private var currentPage = 0

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(actionButton)
        setupConstraints()
        currentItems = viewModel.pages.first?.items ?? []
    }

    // MARK: - Private Helpers

    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            actionButton.heightAnchor.constraint(equalToConstant: 60),
            actionButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }

    @objc
    private func displayStats() {
        let bottomSheetVC = StatisticsViewController(items: currentItems)
        if let sheet = bottomSheetVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
//            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }

        present(bottomSheetVC, animated: true)
    }

    // MARK: - UISearchBarDelegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            currentItems = viewModel.pages[currentPage].items
        } else {
            currentItems = currentItems.filter { $0.title.contains(searchText) }
        }
        tableView.reloadSections(IndexSet(integer: 2), with: .automatic)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1:
            return 1
        case 2:
            return currentItems.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CarouselTableViewCell.identifier, for: indexPath) as! CarouselTableViewCell
            cell.configure(with: carouselImages)
            cell.collectionViewDelegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchBarTableViewCell.identifier, for: indexPath) as! SearchBarTableViewCell
            cell.searchBar.delegate = self
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ListItemCell.identifier) as? ListItemCell else {
                return UITableViewCell()
            }
            cell.configureCell(item: currentItems[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return carouselHeight
        case 1:
            return 60
        case 2:
            return 120
        default:
            return 0
        }
    }
}

// MARK: - CarouselTableViewCellDelegate

extension ViewController: CarouselTableViewCellDelegate {

    func carouselTableViewCell(_ cell: CarouselTableViewCell, didChangePageTo page: Int) {
        currentPage = page
        currentItems = viewModel.pages[page].items
        tableView.reloadSections(IndexSet(integer: 2), with: .automatic)
    }
}
