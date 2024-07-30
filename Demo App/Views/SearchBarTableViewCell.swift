//
//  SearchBarTableViewCell.swift
//  Demo App
//
//  Created by Subodh Jondhale on 30/07/24.
//

import UIKit

class SearchBarTableViewCell: UITableViewCell {

    static let identifier = "SearchTableViewCell"

    // MARK: - Views

    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.barStyle = .black
        sb.barTintColor = .black
        sb.searchBarStyle = .minimal
        sb.backgroundColor = UIColor.clear 
        sb.searchTextField.textColor = .darkGray

        sb.placeholder = "Search"
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()

    // MARK: Overriden Methods

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        selectionStyle = .none
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Helpers

    private func setupViews() {
        contentView.addSubview(searchBar)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            searchBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
