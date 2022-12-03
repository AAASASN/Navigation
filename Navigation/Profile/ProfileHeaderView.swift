//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Александр Мараенко on 03.12.2022.
//

import UIKit

class ProfileHeaderView: UIView, UITextFieldDelegate {
    
    var viewForImage: UIView!
    var button: UIButton!
    var statusLabel: UILabel!
    var nameLabel: UILabel!
    var textField: UITextField!
    
    private var statusText: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.settings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func settings() {
        
        viewForImage = {
            // настройка вью с котиком
            // размер вью в макете не указан выставил на глаз
            let viewForImage = UIView(frame: CGRect(x: 16, y: 80, width: 110, height: 110))
            viewForImage.layer.cornerRadius = 55
            viewForImage.layer.borderWidth = 3
            viewForImage.layer.borderColor = UIColor.white.cgColor
            let imageView = UIImageView(image: UIImage(named: "cat3"))
            imageView.frame = CGRect(x: 3, y: 3, width: 104, height: 104)
            viewForImage.clipsToBounds = true
            viewForImage.addSubview(imageView)
            return viewForImage
        }()
        
        button = {
            // настройка кнопки
            let button = UIButton(frame: CGRect(x: 16, y: 231, width: self.frame.maxX - 32, height: 50))
            button.layer.backgroundColor = UIColor.systemBlue.cgColor
            // в макете указан cornerRadius = 4 по факту около 13
            button.layer.cornerRadius = 13
            // настройки тени в макете также не сответствуют в цифрах и по фактку, не стал подгонять
            button.layer.shadowOffset = CGSize(width: 4, height: 4)
            button.layer.shadowRadius = 4
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.7
            // Font кнопки в макете ни как не указан
            button.setTitle("Show status", for: .normal)
            button.setTitleColor(.white, for: .normal)
            return button
        }()
        
        statusLabel = {
            // настройки лейбла со статусом
            // в макете не указана высота лейбла задал 14 как размер font
            let statusLabel = UILabel(frame: CGRect(x: 142, y: 158, width: self.frame.maxX - 142 - 16, height: 16))
            statusLabel.text = "Wating for something..."
            statusLabel.textColor = UIColor.gray
            statusLabel.font = UIFont.systemFont(ofSize: CGFloat(14), weight: .regular)
            return statusLabel
        }()
        
        nameLabel = {
            // настройки лейбла со именем
            let nameLabel = UILabel(frame: CGRect(x: 142, y: 91, width: self.frame.maxX - 142 - 16, height: 18))
            nameLabel.text = "Itchy Cat"
            nameLabel.textColor = UIColor.black
            nameLabel.font = UIFont.systemFont(ofSize: CGFloat(18), weight: .bold)
            return nameLabel
        }()
        
        textField = {
            //настройки textField
            let textField = UITextField(frame: CGRect(x: 142, y: 180, width: self.frame.maxX - 142 - 16, height: 40))
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.black.cgColor
            textField.layer.cornerRadius = 12
            textField.font = UIFont.systemFont(ofSize: CGFloat(15), weight: .regular)
            textField.layer.backgroundColor = UIColor.white.cgColor
            textField.indent(size: 8)
            return textField
        }()
        
        
        // добавляем кнопку
        self.addSubview(button)
        // добавляем вью с котиком
        self.addSubview(viewForImage)
        // добавляем statusLabel
        self.addSubview(statusLabel)
        // добавляем nameLabel
        self.addSubview(nameLabel)
        // добавляем textField
        self.addSubview(textField)
        
        //
        self.textField.delegate = self
        
        // добавляем таргет
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
    }
    
    
    // обработчик таргета
    @objc
    func buttonPressed() {
        if textField.text != nil {
            statusLabel.text = textField.text
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

extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}
