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
    
    func cellSetting() {
        
        authorLabel = {
            let authorLabel = UILabel(frame: .zero)
            authorLabel.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(authorLabel)
            NSLayoutConstraint.activate([authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                                         authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                                         authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                                        ])
            
            authorLabel.font = .systemFont(ofSize: 20, weight: .bold)
            authorLabel.textColor = .black
            authorLabel.numberOfLines = 2
            return authorLabel
        }()
        
        imageViewForPicture = {
            let imageViewForPicture = UIImageView(frame: .zero)
            imageViewForPicture.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(imageViewForPicture)
            
            NSLayoutConstraint.activate([imageViewForPicture.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                         imageViewForPicture.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
                                         imageViewForPicture.heightAnchor.constraint(equalTo: contentView.widthAnchor),
                                         imageViewForPicture.widthAnchor.constraint(equalTo: contentView.widthAnchor)
                                        ])
            
            imageViewForPicture.backgroundColor = .black
            // imageViewForPicture.alpha = 0.3
            
            imageViewForPicture.contentMode = .scaleAspectFit
            
            imageViewForPicture.clipsToBounds = true
            
            
            return imageViewForPicture
            
        }()
        
        descriptionLabel = {
            
            let descriptionLabel = UILabel(frame: .zero)
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(descriptionLabel)
            NSLayoutConstraint.activate([
                descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                descriptionLabel.topAnchor.constraint(equalTo: imageViewForPicture.bottomAnchor, constant: 16),
                descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                // descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            ])
            
            descriptionLabel.font = .systemFont(ofSize: 14, weight: .medium)
            descriptionLabel.textColor = .systemGray
            descriptionLabel.numberOfLines = 0
            
            return descriptionLabel

        }()
        
        likesLabel = {
            
            let likesLabel = UILabel(frame: .zero)
//            likesLabel.translatesAutoresizingMaskIntoConstraints = false
//            self.contentView.addSubview(likesLabel)
//            NSLayoutConstraint.activate([
//                likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//                likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
//                likesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//                likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
//            ])
            
            likesLabel.font = .systemFont(ofSize: 16, weight: .regular)
            likesLabel.textColor = .black
            likesLabel.numberOfLines = 1
            
            return likesLabel

        }()
        
        viewsLabel = {
            
            let viewsLabel = UILabel(frame: .zero)
//            likesLabel.translatesAutoresizingMaskIntoConstraints = false
//            self.contentView.addSubview(viewsLabel)
//            NSLayoutConstraint.activate([
//                viewsLabel.leadingAnchor.constraint(equalTo: likesLabel.leadingAnchor, constant: 16),
//                viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
//                viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//                viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
//            ])
            
            viewsLabel.font = .systemFont(ofSize: 16, weight: .regular)
            viewsLabel.textColor = .black
            viewsLabel.numberOfLines = 1
            
            return viewsLabel

        }()
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 10
        //stackView.backgroundColor = .gray
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
         
        NSLayoutConstraint.activate([stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                                     stackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
                                     stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                                     stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
                                    ])

        stackView.addArrangedSubview(likesLabel)
        stackView.addArrangedSubview(viewsLabel)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
