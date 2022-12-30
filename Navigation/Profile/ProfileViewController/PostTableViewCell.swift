//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Александр Мараенко on 26.12.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    var authorLabel: UILabel!
    var descriptionLabel: UILabel!
    var imageViewForPicture: UIImageView!
    var likesLabel: UILabel!
    var viewsLabel: UILabel!
    var stackView: UIStackView!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        cellSetting()
        cellAddToContentView()
        cellConstraintSettings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - cellConstraintSettings
    func cellConstraintSettings() {
        NSLayoutConstraint.activate([authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                                     authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                                     authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                                     imageViewForPicture.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                     imageViewForPicture.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
                                     imageViewForPicture.heightAnchor.constraint(equalTo: contentView.widthAnchor),
                                     imageViewForPicture.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                                     descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                                     descriptionLabel.topAnchor.constraint(equalTo: imageViewForPicture.bottomAnchor, constant: 16),
                                     descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                                     stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                                     stackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
                                     stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                                     stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)])
    }

    
    // MARK: - cellAddToContentView
    func cellAddToContentView() {
        contentView.addSubview(authorLabel)
        contentView.addSubview(imageViewForPicture)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(likesLabel)
        stackView.addArrangedSubview(viewsLabel)
    }

    // MARK: - cellSetting
    func cellSetting() {
        authorLabel = {
            let authorLabel = UILabel(frame: .zero)
            authorLabel.translatesAutoresizingMaskIntoConstraints = false
            authorLabel.font = .systemFont(ofSize: 20, weight: .bold)
            authorLabel.textColor = .black
            authorLabel.numberOfLines = 2
            return authorLabel
        }()
        
        imageViewForPicture = {
            let imageViewForPicture = UIImageView(frame: .zero)
            imageViewForPicture.translatesAutoresizingMaskIntoConstraints = false
            imageViewForPicture.backgroundColor = .black
            imageViewForPicture.contentMode = .scaleAspectFit
            imageViewForPicture.clipsToBounds = true
            return imageViewForPicture
        }()
        
        descriptionLabel = {
            let descriptionLabel = UILabel(frame: .zero)
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.font = .systemFont(ofSize: 14, weight: .medium)
            descriptionLabel.textColor = .systemGray
            descriptionLabel.numberOfLines = 0
            return descriptionLabel
        }()
        
        likesLabel = {
            let likesLabel = UILabel(frame: .zero)
            likesLabel.font = .systemFont(ofSize: 16, weight: .regular)
            likesLabel.textColor = .black
            likesLabel.numberOfLines = 1
            return likesLabel
        }()
        
        viewsLabel = {
            let viewsLabel = UILabel(frame: .zero)
            viewsLabel.font = .systemFont(ofSize: 16, weight: .regular)
            viewsLabel.textColor = .black
            viewsLabel.numberOfLines = 1
            return viewsLabel
        }()
        
        stackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            stackView.alignment = .fill
            stackView.spacing = 10
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
    }
}
