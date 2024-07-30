//
//  ListItemCell.swift
//  Demo App
//
//  Created by Subodh Jondhale on 30/07/24.
//

import UIKit

class ListItemCell: UITableViewCell {

    static let identifier = "ListItemCell"

    // MARK: - Subviews

    private lazy var itemImageView: UIImageView = {
        let itemImageView = UIImageView()
        itemImageView.layer.masksToBounds = true
        itemImageView.layer.cornerRadius = 10
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        return itemImageView
    }()

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        return titleLabel
    }()

    private lazy var subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return subTitleLabel
    }()

    // MARK: - Overidden Methods

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(itemImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.layer.cornerRadius = 20
        selectionStyle = .none

        let color = UIColor(red: 202/255.0, green: 218/255.0, blue: 191/255.0, alpha: 1.0)
        contentView.backgroundColor = color
        backgroundColor = .clear
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
    }

    // MARK: - Private Helper

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // itemImageView
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            itemImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 80),
            itemImageView.heightAnchor.constraint(equalToConstant: 80),

            // titleLabel
            titleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            // subTitleLabel
            subTitleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 20),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            subTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25)
        ])
    }

    // MARK: - Public APIs

    func configureCell(item: ListItem) {
        itemImageView.image = UIImage(named: item.image)
        titleLabel.text = item.title
        subTitleLabel.text = item.subtitle
    }
}
