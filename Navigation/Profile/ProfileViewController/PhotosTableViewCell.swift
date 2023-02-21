//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Александр Мараенко on 29.12.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    var label: UILabel!
    var nextImage: UIImageView!
    var stackView: UIStackView!
    
    var image1: UIImageView!
    var image2: UIImageView!
    var image3: UIImageView!
    var image4: UIImageView!

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        cellUIContentCreate()
        cellAddToContentView()
        cellLayoutSettings()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellUIContentCreate()  {
        
        // label
        label = UILabel(frame: .zero)
        label.text = "Photos"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.tintColor = .black
        
        // nextImage
        nextImage = UIImageView(frame: .zero)
        nextImage.image = UIImage(systemName: "arrow.forward")

        image1 = {
            let image1 = UIImageView(frame: .zero)
            image1.clipsToBounds = true
            image1.contentMode = .scaleAspectFill
            image1.layer.cornerRadius = 6
            image1.backgroundColor = .gray
            return image1
        }()
        
        image2 = {
            let image2 = UIImageView(frame: .zero)
            image2.clipsToBounds = true
            image2.contentMode = .scaleAspectFill
            image2.layer.cornerRadius = 6
            image2.backgroundColor = .gray
            return image2
        }()
        
        image3 = {
            let image3 = UIImageView(frame: .zero)
            image3.clipsToBounds = true
            image3.contentMode = .scaleAspectFill
            image3.layer.cornerRadius = 6
            image3.backgroundColor = .gray
            return image3
        }()
        
        image4 = {
            let image4 = UIImageView(frame: .zero)
            image4.clipsToBounds = true
            image4.contentMode = .scaleAspectFill
            image4.layer.cornerRadius = 6
            image4.layer.backgroundColor = UIColor.gray.cgColor
            return image4
        }()
        
        stackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.alignment = .center
            stackView.spacing = 8
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
    }
    
    func cellAddToContentView() {
        stackView.addArrangedSubview(image1)
        stackView.addArrangedSubview(image2)
        stackView.addArrangedSubview(image3)
        stackView.addArrangedSubview(image4)
        self.contentView.addSubview(label)
        self.contentView.addSubview(nextImage)
        self.contentView.addSubview(stackView)
    }
    
    
    func cellLayoutSettings() {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        nextImage.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        image1.translatesAutoresizingMaskIntoConstraints = false
        image2.translatesAutoresizingMaskIntoConstraints = false
        image3.translatesAutoresizingMaskIntoConstraints = false
        image4.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            label.bottomAnchor.constraint(equalTo: self.stackView.topAnchor, constant: -12),
            label.trailingAnchor.constraint(equalTo: self.nextImage.leadingAnchor, constant: -12),
            label.heightAnchor.constraint(equalToConstant: 24 ),

            nextImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            nextImage.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            nextImage.heightAnchor.constraint(equalToConstant: 24),
            nextImage.widthAnchor.constraint(equalTo: nextImage.heightAnchor),
            
            image1.heightAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.13),
            image2.heightAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.13),
            image3.heightAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.13),
            image4.heightAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.13),
 
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
            ])
        
    }
    
}
