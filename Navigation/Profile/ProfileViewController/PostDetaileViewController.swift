//
//  PostDetaileViewController.swift
//  Navigation
//
//  Created by Александр Мараенко on 16.02.2023.
//

import UIKit

class PostDetaileViewController: UIViewController {
    
    var post = Post(author: "", description: "", image: "", likes: 0, views: 0)
    
    var authorLabel: UILabel!
    var descriptionLabel: UITextView!
    var imageViewForPicture: UIImageView!
    var likesLabel: UILabel!
    var viewsLabel: UILabel!
    var stackView: UIStackView!
    
    var closuerForLikesCountingOnDetaileVC: (() -> Void)!
    var closuerForViewsCountingAndDetailwControllerPresent: (() -> Void)!
    
    var tapOnImageViewForPicture: UITapGestureRecognizer!
    var tapOnLikesLabel: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        viewSetting()
        
        addSubViews()
        
        elementsConstraintSettings()
        
        elementsContent()
        
        gestureRecognizer()
        
    }
    
    func gestureRecognizer() {
        
        // likesLabel
        tapOnLikesLabel = UITapGestureRecognizer()
        tapOnLikesLabel.addTarget(self, action: #selector(likesLabelTap(_:)))
        likesLabel.addGestureRecognizer(tapOnLikesLabel)
    }
    
    
    @objc
    func likesLabelTap(_ gestureRecognizer: UITapGestureRecognizer) {
        
        closuerForLikesCountingOnDetaileVC()
        print("likesLabelTap - \(post.likes + 1)")
        post.likes += 1
        likesLabel.text = "Likes: \(post.likes)"
        
    }

    
    // MARK: - cellSetting
    func viewSetting() {
        
        authorLabel = {
            let authorLabel = UILabel(frame: .zero)
            authorLabel.font = .systemFont(ofSize: 20, weight: .bold)
            authorLabel.textColor = .black
            authorLabel.numberOfLines = 2
            return authorLabel
        }()
        
        imageViewForPicture = {
            let imageViewForPicture = UIImageView(frame: .zero)
            imageViewForPicture.backgroundColor = .black
            imageViewForPicture.contentMode = .scaleAspectFit
            imageViewForPicture.clipsToBounds = true
            imageViewForPicture.isUserInteractionEnabled = false
            return imageViewForPicture
        }()
        
        descriptionLabel = {
            let descriptionLabel = UITextView(frame: .zero)
            descriptionLabel.font = .systemFont(ofSize: 14, weight: .medium)
            descriptionLabel.textColor = .systemGray
            return descriptionLabel
        }()
        
        likesLabel = {
            let likesLabel = UILabel(frame: .zero)
            likesLabel.font = .systemFont(ofSize: 16, weight: .regular)
            likesLabel.textColor = .black
            likesLabel.numberOfLines = 1
            likesLabel.isUserInteractionEnabled = true
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
            return stackView
        }()
        
    }
    
    // MARK: - cellAddToview
    func addSubViews() {
        view.addSubview(authorLabel)
        view.addSubview(imageViewForPicture)
        view.addSubview(descriptionLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(likesLabel)
        stackView.addArrangedSubview(viewsLabel)
    }
    
    // MARK: - cellConstraintSettings
    func elementsConstraintSettings() {
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        imageViewForPicture.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                                     authorLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
                                     authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                                     authorLabel.heightAnchor.constraint(equalToConstant: 30),
                                     
                                     imageViewForPicture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     imageViewForPicture.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
                                     imageViewForPicture.heightAnchor.constraint(equalTo: view.widthAnchor),
                                     imageViewForPicture.widthAnchor.constraint(equalTo: view.widthAnchor),
                                     
                                     descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                                     descriptionLabel.topAnchor.constraint(equalTo: imageViewForPicture.bottomAnchor, constant: 16),
                                     descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                                     
                                     stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                                     stackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
                                     stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                                     stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)])
    }


    func elementsContent() {
         
        authorLabel.text = post.author
        imageViewForPicture.image = UIImage(named: post.image)
        descriptionLabel.text = post.description
        likesLabel.text = "Likes: \(post.likes)"
        viewsLabel.text = "Views: \(post.views)"
        
    }

}
