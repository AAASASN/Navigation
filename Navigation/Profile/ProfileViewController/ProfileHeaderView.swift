//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Александр Мараенко on 03.12.2022.
//

import UIKit

class ProfileHeaderView: UIView, UITextFieldDelegate {
    
    var avatarImageView: UIView!
    var fullNameLabel: UILabel!
    var statusLabel: UILabel!
    var statusTextField: UITextField!
    var setStatusButton: UIButton!
    
    private var statusText: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.settings()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func settings() {
        
        avatarImageView = {
            let viewForImage = UIView(frame: .zero)
            viewForImage.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(viewForImage)
            NSLayoutConstraint.activate([viewForImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
                                         viewForImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
                                         viewForImage.widthAnchor.constraint(equalToConstant: 110),
                                         viewForImage.heightAnchor.constraint(equalToConstant: 110)])
            viewForImage.layer.cornerRadius = 55
            viewForImage.layer.borderWidth = 3
            viewForImage.layer.borderColor = UIColor.systemGray5.cgColor
            let imageView = UIImageView(image: UIImage(named: "cat3"))
            imageView.frame = CGRect(x: 3, y: 3, width: 104, height: 104)
            viewForImage.clipsToBounds = true
            viewForImage.addSubview(imageView)
            return viewForImage
        }()
        
        fullNameLabel = {
            let nameLabel = UILabel(frame: .zero)
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(nameLabel)
            NSLayoutConstraint.activate([nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
                                         nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
                                         nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                                         nameLabel.heightAnchor.constraint(equalToConstant: 18)])
            nameLabel.text = "Itchy Cat"
            nameLabel.textColor = UIColor.black
            nameLabel.font = UIFont.systemFont(ofSize: CGFloat(18), weight: .bold)
            return nameLabel
        }()
        
        setStatusButton = {
            let button = UIButton(frame: .zero)
            button.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(button)
            NSLayoutConstraint.activate([button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
                                         button.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 56),
                                         button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                                         button.heightAnchor.constraint(equalToConstant: 50),
                                         button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)])
            button.layer.backgroundColor = UIColor.systemBlue.cgColor
            button.layer.cornerRadius = 13
            button.layer.shadowOffset = CGSize(width: 4, height: 4)
            button.layer.shadowRadius = 4
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.7
            button.setTitle("Show status", for: .normal)
            button.setTitleColor(.white, for: .normal)
            return button
        }()
        
        statusLabel = {
            let statusLabel = UILabel(frame: .zero)
            statusLabel.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(statusLabel)
            NSLayoutConstraint.activate([statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
                                         statusLabel.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -74),
                                         statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                                         statusLabel.heightAnchor.constraint(equalToConstant: 14)])
            statusLabel.text = "Wating for something..."
            statusLabel.textColor = UIColor.gray
            statusLabel.font = UIFont.systemFont(ofSize: CGFloat(14), weight: .regular)
            return statusLabel
        }()
                
        statusTextField = {
            let textField = UITextField(frame: .zero)
            textField.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(textField)
            NSLayoutConstraint.activate([textField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
                                         textField.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -20),
                                         textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                                         textField.heightAnchor.constraint(equalToConstant: 40)])
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.black.cgColor
            textField.layer.cornerRadius = 12
            textField.font = UIFont.systemFont(ofSize: CGFloat(15), weight: .regular)
            textField.layer.backgroundColor = UIColor.white.cgColor
            textField.indent(size: 8)
            textField.placeholder = "Set your status..."
            return textField
        }()
        
        self.statusTextField.delegate = self
        
        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
    }
    
    @objc
    func buttonPressed() {
        if statusTextField.text != nil {
            statusLabel.text = statusTextField.text
        }
    }
    
    @objc
    func statusTextChanged(_ textField: UITextField) {
        if let status = textField.text {
            statusText = status
            print("В переменную statusText было записано \(statusText)")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    
}

