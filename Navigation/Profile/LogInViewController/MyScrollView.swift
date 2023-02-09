//
//  MyScrollView.swift
//  Navigation
//
//  Created by Александр Мараенко on 13.12.2022.
//

import Foundation
import UIKit

class MyScrollView: UIScrollView, UIScrollViewDelegate {
    
    var contentView: UIView!
    var iconView: UIView!
    var logoImage: UIImageView!
    var rectForTextFields: UIView!
    var loginTextField: UITextField!
    var passTextField: UITextField!
    var line: UIView!
    var labelAboutSixChar: UILabel!
    var button: UIButton!
    
    var shakeAnimation = CABasicAnimation()
    
    
    func settings()  {
        
        // contentView
        contentView = {
            let contentView = UIView(frame: .zero)
            contentView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(contentView)
            //contentView.clipsToBounds = true
            NSLayoutConstraint.activate([
                contentView.heightAnchor.constraint(equalTo: self.heightAnchor),
                contentView.widthAnchor.constraint(equalTo: self.widthAnchor),
                contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
            return contentView
        }()
        
        // iconView
        iconView = {
            let iconView = UIView(frame: .zero)
            iconView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(iconView)
            iconView.clipsToBounds = true
            NSLayoutConstraint.activate([
                iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
                iconView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                iconView.heightAnchor.constraint(equalToConstant: 100),
                iconView.widthAnchor.constraint(equalToConstant: 100)
            ])
            return iconView
        }()
        
        // logoImage
        logoImage = {
            let logoImage = UIImageView(image: UIImage(named: "logo"))
            logoImage.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            iconView.addSubview(logoImage)
            return logoImage
        }()
        
        // rectForTextFields
        rectForTextFields = {
            let rectForTextFields = UIView(frame: .zero)
            rectForTextFields.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(rectForTextFields)
            // iconView.clipsToBounds = true
            NSLayoutConstraint.activate([
                rectForTextFields.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 80),
                rectForTextFields.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                rectForTextFields.heightAnchor.constraint(equalToConstant: 100),
                rectForTextFields.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                rectForTextFields.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            ])
            rectForTextFields.backgroundColor = .systemGray6
            rectForTextFields.layer.cornerRadius = 10
            rectForTextFields.layer.borderWidth = 0.5
            rectForTextFields.layer.borderColor = UIColor.lightGray.cgColor
            return rectForTextFields
        }()
        
        // loginTextField
        loginTextField = {
            let loginTextField = UITextField(frame: .zero)
            loginTextField.translatesAutoresizingMaskIntoConstraints = false
            rectForTextFields.addSubview(loginTextField)
            loginTextField.textColor = .black
            loginTextField.font = .systemFont(ofSize: 16)
            loginTextField.autocapitalizationType = .none
            loginTextField.placeholder = "Email or phone"
            NSLayoutConstraint.activate([
                loginTextField.centerXAnchor.constraint(equalTo: rectForTextFields.centerXAnchor),
                loginTextField.topAnchor.constraint(equalTo: rectForTextFields.topAnchor, constant: 0),
                loginTextField.bottomAnchor.constraint(equalTo: rectForTextFields.bottomAnchor, constant: -50),
                loginTextField.leadingAnchor.constraint(equalTo: rectForTextFields.leadingAnchor, constant: 16),
                loginTextField.trailingAnchor.constraint(equalTo: rectForTextFields.trailingAnchor, constant: -16)
            ])
            return loginTextField
        }()
        
        // passTextField
        passTextField = {
            let passTextField = UITextField(frame: .zero)
            passTextField.translatesAutoresizingMaskIntoConstraints = false
            rectForTextFields.addSubview(passTextField)
            passTextField.textColor = .black
            passTextField.font = .systemFont(ofSize: 16)
            passTextField.autocapitalizationType = .none
            passTextField.placeholder = "Password"
            passTextField.isSecureTextEntry = true
            NSLayoutConstraint.activate([
                passTextField.centerXAnchor.constraint(equalTo: rectForTextFields.centerXAnchor),
                passTextField.topAnchor.constraint(equalTo: rectForTextFields.topAnchor, constant: 50),
                passTextField.bottomAnchor.constraint(equalTo: rectForTextFields.bottomAnchor, constant: 0),
                passTextField.leadingAnchor.constraint(equalTo: rectForTextFields.leadingAnchor, constant: 16),
                passTextField.trailingAnchor.constraint(equalTo: rectForTextFields.trailingAnchor, constant: -16)
            ])
            return passTextField
        }()
        
        // line
        line = {
            let line = UIView(frame: .zero)
            line.translatesAutoresizingMaskIntoConstraints = false
            rectForTextFields.addSubview(line)
            NSLayoutConstraint.activate([
                line.centerYAnchor.constraint(equalTo: rectForTextFields.centerYAnchor),
                line.heightAnchor.constraint(equalToConstant: 0.5),
                line.leadingAnchor.constraint(equalTo: rectForTextFields.leadingAnchor, constant: 0  ),
                line.trailingAnchor.constraint(equalTo: rectForTextFields.trailingAnchor, constant: 0  )
            ])
            line.backgroundColor = .lightGray
            return line
        }()
        
        labelAboutSixChar = {
            let labelAboutSixChar = UILabel(frame: .zero)
            labelAboutSixChar.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(labelAboutSixChar)
            NSLayoutConstraint.activate([
                labelAboutSixChar.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 8),
                labelAboutSixChar.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                labelAboutSixChar.heightAnchor.constraint(equalToConstant: 20),
                labelAboutSixChar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16  ),
                labelAboutSixChar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16 )
            ])
            
            // labelAboutSixChar.backgroundColor = .systemGray5
            labelAboutSixChar.text = " пароль должен состоять минимум из шести символов"
            labelAboutSixChar.font = .systemFont(ofSize: 12, weight: .light)
            labelAboutSixChar.textColor = .red
            labelAboutSixChar.isHidden = true
            return labelAboutSixChar
        }()
        
        // button
        button = {
            let button = UIButton(frame: .zero)
            button.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(button)
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: rectForTextFields.bottomAnchor, constant: 36),
                button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                button.heightAnchor.constraint(equalToConstant: 50),
                button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16  ),
                button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16 )
            ])
            button.layer.backgroundColor = UIColor(red: 0.28, green: 0.52, blue: 0.80, alpha: 1.00).cgColor
            button.layer.cornerRadius = 10
            button.setTitle("Log In", for: .normal)
            button.setTitleColor(.white, for: .normal)
            rectForTextFields.clipsToBounds = true
            return button
        }()
        
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
    
    func checkLoginAndPass() -> Bool {
        
        if loginTextField.text == "" && passTextField.text == "" {
            
            createShakeAnimation(object: loginTextField)
            createShakeAnimation(object: passTextField)
            
        } else if loginTextField.text == "" {
            
            createShakeAnimation(object: loginTextField)
            
        } else if passTextField.text == ""  {
            
            createShakeAnimation(object: passTextField)
            
        } else if let charCount = passTextField.text?.count  {
            
            if charCount > 6 {
                
                
                
                labelAboutSixChar.isHidden = true
                return true

            } else {
                
                labelAboutSixChar.isHidden = false

            }
            
        }
        
        return false
    }
    
    
    
}
