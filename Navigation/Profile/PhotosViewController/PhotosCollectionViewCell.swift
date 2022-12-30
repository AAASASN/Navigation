//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Александр Мараенко on 30.12.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setting()  {
        imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                                     imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
                                     imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
                                     imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
                                    ])
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    
    
}
