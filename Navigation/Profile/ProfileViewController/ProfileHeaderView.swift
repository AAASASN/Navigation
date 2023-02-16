//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Александр Мараенко on 03.12.2022.
//

import UIKit

class ProfileHeaderView: UIView, UITextFieldDelegate {
    
    var avatarImageView: UIView!
    var imageViewInAvatarImageView: UIImageView!
    var fullNameLabel: UILabel!
    var statusLabel: UILabel!
    var statusTextField: UITextField!
    var setStatusButton: UIButton!
    
    var tapOnAvatarImageView: UITapGestureRecognizer!
    
    var clouserForAnimationOnProfileViewController: (()->Void)!
    
    private var statusText: String = ""
    
    var shakeAnimation = CABasicAnimation()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.settings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func settings() {
        
        createViewElements()
        switchAutoresizingMaskIntoConstraints()
        addSubviewsToSelf()
        setNSLayoutConstraint()
        
        self.statusTextField.delegate = self
        
        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        tapOnAvatarImageView = UITapGestureRecognizer()
        tapOnAvatarImageView.addTarget(self, action: #selector(tapOnAvatarImageViewFunc(_:)))
        avatarImageView.addGestureRecognizer(tapOnAvatarImageView)
        
    }
    
    
    func createViewElements() {
        
        avatarImageView = {
            let avatarImageView = UIView(frame: .zero)
            avatarImageView.layer.cornerRadius = 55
            avatarImageView.layer.borderWidth = 3
            avatarImageView.layer.borderColor = UIColor.systemGray5.cgColor
            avatarImageView.clipsToBounds = true
            return avatarImageView
        }()
        
        imageViewInAvatarImageView = {
            let imageViewInAvatarImageView = UIImageView(image: UIImage(named: "cat3"))
            imageViewInAvatarImageView.frame = CGRect(x: 3, y: 3, width: 104, height: 104)
            return imageViewInAvatarImageView
        }()
        
        
        fullNameLabel = {
            let fullNameLabel = UILabel(frame: .zero)
            fullNameLabel.text = "Itchy Cat"
            fullNameLabel.textColor = UIColor.black
            fullNameLabel.font = UIFont.systemFont(ofSize: CGFloat(18), weight: .bold)
            return fullNameLabel
        }()
        
        setStatusButton = {
            let setStatusButton = UIButton(frame: .zero)
            setStatusButton.layer.backgroundColor = UIColor.systemBlue.cgColor
            setStatusButton.layer.cornerRadius = 13
            setStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
            setStatusButton.layer.shadowRadius = 4
            setStatusButton.layer.shadowColor = UIColor.black.cgColor
            setStatusButton.layer.shadowOpacity = 0.7
            setStatusButton.setTitle("Show status", for: .normal)
            setStatusButton.setTitleColor(.white, for: .normal)
            return setStatusButton
        }()
        
        statusLabel = {
            let statusLabel = UILabel(frame: .zero)
            statusLabel.text = "Wating for something..."
            statusLabel.textColor = UIColor.gray
            statusLabel.font = UIFont.systemFont(ofSize: CGFloat(14), weight: .regular)
            return statusLabel
        }()
        
        statusTextField = {
            let statusTextField = UITextField(frame: .zero)
            statusTextField.layer.borderWidth = 1
            statusTextField.layer.borderColor = UIColor.black.cgColor
            statusTextField.layer.cornerRadius = 12
            statusTextField.font = UIFont.systemFont(ofSize: CGFloat(15), weight: .regular)
            statusTextField.layer.backgroundColor = UIColor.white.cgColor
            statusTextField.indent(size: 8)
            statusTextField.placeholder = "Set your status..."
            return statusTextField
        }()
        
    }
    
    func switchAutoresizingMaskIntoConstraints() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        setStatusButton.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviewsToSelf() {
        self.addSubview(fullNameLabel)
        self.addSubview(setStatusButton)
        self.addSubview(statusLabel)
        self.addSubview(statusTextField)
        self.addSubview(avatarImageView)
        avatarImageView.addSubview(imageViewInAvatarImageView)
    }
    
    func setNSLayoutConstraint() {
        
        NSLayoutConstraint.activate([avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
                                     avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
                                     avatarImageView.widthAnchor.constraint(equalToConstant: 110),
                                     avatarImageView.heightAnchor.constraint(equalToConstant: 110),
                                     
                                     fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
                                     fullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
                                     fullNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                                     fullNameLabel.heightAnchor.constraint(equalToConstant: 18),
                                     
                                     setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
                                     setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 56),
                                     setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                                     setStatusButton.heightAnchor.constraint(equalToConstant: 50),
                                     setStatusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
                                     
                                     statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
                                     statusLabel.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -74),
                                     statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                                     statusLabel.heightAnchor.constraint(equalToConstant: 14),
                                     
                                     statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
                                     statusTextField.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -20),
                                     statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                                     statusTextField.heightAnchor.constraint(equalToConstant: 40)
                                     
                                    ])
    }
    
    
    @objc
    func buttonPressed() {
        if statusTextField.text == "" {
            createShakeAnimation(object: statusTextField)
        } else {
            statusLabel.text = statusTextField.text
        }
    }
    
    func createShakeAnimation(object: AnyObject) {
        
        shakeAnimation = CABasicAnimation(keyPath: "position")
        shakeAnimation.duration = 0.01
        shakeAnimation.repeatCount = 10
        shakeAnimation.autoreverses = true
        shakeAnimation.fromValue = NSValue(cgPoint: CGPointMake(object.center.x - 5, object.center.y))
        shakeAnimation.toValue = NSValue(cgPoint: CGPointMake(object.center.x + 5, object.center.y))
        object.layer.add(shakeAnimation, forKey: "position")
        
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
    
    @objc func tapOnAvatarImageViewFunc(_ gestureRecognizer: UITapGestureRecognizer) {

        // вызов клоужера для отработки анимации на ProfileViewController
        clouserForAnimationOnProfileViewController()
        
    }
    
}

