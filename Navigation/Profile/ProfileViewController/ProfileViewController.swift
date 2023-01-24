//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Александр Мараенко on 23.11.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var postArray: [Post]!
    var tableView: UITableView!
    var tap: UITapGestureRecognizer! = nil
    
    var profileHeaderView: ProfileHeaderView!
    
    // animation elements
    var whiteViewForAnimation: UIView!
    var imageViewForAnimationView: UIImageView!
    var animatingView: UIView!
    var closeButton: UIButton!
    var smallWhiteView: UIView!
    
    //
    var tempY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSettings()
        profileHeaderViewSettings()
        postArray = PostArray.createPostArray()
        tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tableView.reloadData()
        
        removeKeyboardNotifications()
    }
    
    // MARK: - tableViewSettings
    func tableViewSettings() {
        
        view.backgroundColor = .white
        
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                                    ])
        
        tableView.backgroundColor = .white
        tableView.separatorInset.left = .zero
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}


// MARK: - UITableViewDelegate  UITableViewDataSource
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        if section == 1 { return postArray.count }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellForReturn = UITableViewCell()
        
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = PhotosTableViewCell(style: .default, reuseIdentifier: "PhotosTableViewCellReuseIdentifier")
            cell.image1.image = UIImage(named: PhotoGallery.getPhotoArray()[0])
            cell.image2.image = UIImage(named: PhotoGallery.getPhotoArray()[1])
            cell.image3.image = UIImage(named: PhotoGallery.getPhotoArray()[2])
            cell.image4.image = UIImage(named: PhotoGallery.getPhotoArray()[3])
            
            cellForReturn = cell
        }
        
        if indexPath.section == 1 {
            let cell = PostTableViewCell(style: .default, reuseIdentifier: "PostTableViewCellReuseIdentifier")
            cell.authorLabel.text = postArray[indexPath.row].author
            cell.imageViewForPicture.image = UIImage(named: postArray[indexPath.row].image)
            cell.descriptionLabel.text = postArray[indexPath.row].description
            cell.likesLabel.text = "Likes: \(postArray[indexPath.row].likes)"
            cell.viewsLabel.text = "Views: \(postArray[indexPath.row].views)"
            cell.selectionStyle = .none
            cellForReturn = cell
        }
        
        return cellForReturn
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let profileHeaderView = self.profileHeaderView else { return UIView(frame: .zero) }
            
            profileHeaderView.backgroundColor = .white
            
            return  profileHeaderView
        }
        if section == 1 {
            return UIView(frame: .zero)
        }
        return UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 250
        }
        
        if section == 1 {
            return 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let photosViewController = PhotosViewController()
            photosViewController.photos = PhotoGallery.getPhotoArray()
            self.navigationController?.pushViewController(photosViewController, animated: true)
        }
    }
    
}

// MARK: - dismissKeyboard
// это расширение возволяет скрыть клавиатуру при косании вне TextField.
extension ProfileViewController {
    
    func registerTapGestureRecognizerForHideKeyboard() {
        tableView.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        tableView.endEditing(true)
        tableView.removeGestureRecognizer(tap)
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func kbWillShow(_ notification: Notification) {
        registerTapGestureRecognizerForHideKeyboard()
    }
}


// MARK: - Animation part
extension ProfileViewController {

    func profileHeaderViewSettings() {
        
        profileHeaderView = ProfileHeaderView(frame: .zero)
        
        // передача замыкания для отработки анимации
        profileHeaderView.clouserForAnimationOnProfileViewController = {
            
            // отрисовываем новые элементы анимации и добавляем их на основной вью контроллера
            self.prepareAnimationElements()

            //
            self.startAnimation()
            
        }
    }
    
    func prepareAnimationElements() {
        
        // белое вью для скрытия всех элементов на корневом вью контроллера
        whiteViewForAnimation = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        whiteViewForAnimation.backgroundColor = .white
        whiteViewForAnimation.alpha = 0
        
        // картинка в автарке
        imageViewForAnimationView = profileHeaderView.imageViewInAvatarImageView
        
        
        // вью аватарки
        animatingView = {
            let avatarImageView = UIView(frame: CGRect(x: 16, y: 16, width: 110, height: 108))
            avatarImageView.layer.cornerRadius = avatarImageView.frame.width/2
            avatarImageView.layer.borderWidth = 3
            avatarImageView.layer.borderColor = UIColor.systemGray5.cgColor
            avatarImageView.clipsToBounds = true
            return avatarImageView
        }()
        // устанавливаем кординату "у" в соответствии с положением хедера таблицы относительно view
        animatingView.frame.origin.y += self.view.safeAreaInsets.top + self.getPositionOffset()
        // сохраняем значение у в переменную для хранения и дальнейшего использования при обратной анимации
        tempY = animatingView.frame.origin.y
        
        
        //          self.profileHeaderView.addSubview(animatingView)
        
        closeButton = {
            let closeButton = UIButton(frame: CGRect(x: self.view.frame.size.width - 56,
                                                     y: self.view.safeAreaInsets.top + 16,
                                                     width: 40,
                                                     height: 40))
            closeButton.backgroundColor = .white
            closeButton.layer.cornerRadius = 20
            let closeButtonAction = UIAction { _ in
                self.startReversAnimation()
            }
            closeButton.addAction(closeButtonAction, for: .allTouchEvents)
            
            let imageView = UIImageView(image: UIImage(systemName: "multiply.circle"))
            imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            closeButton.addSubview(imageView)
            //closeButton.center = imageView.center
            closeButton.clipsToBounds = true
            return closeButton
        }()
        
        //
        smallWhiteView = UIView(frame: CGRect(x: self.view.frame.size.width - 56,
                                              y: self.view.safeAreaInsets.top + 16,
                                              width: 40,
                                              height: 40))
        smallWhiteView.backgroundColor = .white
        
        self.view.addSubview(self.whiteViewForAnimation)
        self.view.addSubview(animatingView)
        animatingView.addSubview(imageViewForAnimationView)
        self.view.addSubview(closeButton)
        self.view.addSubview(smallWhiteView)
    }
    
    func startAnimation() {
        
        // скрывает аватарку в profileHeaderView перед началом анимации
        self.profileHeaderView.avatarImageView.isHidden = true

        UIView.animate(withDuration: 0.5, delay: 0) {
            
            self.animatingView.center.y = self.view.center.y - (self.view.frame.width - 32)/2
            
            self.animatingView.frame.size.height = self.view.frame.width - 32
            self.animatingView.frame.size.width = self.view.frame.width - 32
            
            self.animatingView.layer.cornerRadius = 0 // (self.view.frame.width - 32)/2
            self.animatingView.layer.borderWidth = 7
            self.animatingView.layer.borderColor = UIColor.systemGray3.cgColor
            
            self.imageViewForAnimationView.frame.size.height = self.view.frame.width - 32
            self.imageViewForAnimationView.frame.size.width = self.view.frame.width - 32
            
            self.whiteViewForAnimation.alpha = 1
        }

        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.smallWhiteView.alpha = 0
        }
        
    }
    
    func startReversAnimation() {
        
        // анимация кнопки
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.smallWhiteView.alpha = 1
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.3, animations: {
            
            self.animatingView.frame.origin.x = self.profileHeaderView.avatarImageView.frame.origin.x
            self.animatingView.frame.origin.y = self.profileHeaderView.avatarImageView.frame.origin.x + self.view.safeAreaInsets.top + self.getPositionOffset()
            
            self.animatingView.frame.size.height = 108
            self.animatingView.frame.size.width = 110
            
            self.animatingView.layer.cornerRadius = self.animatingView.frame.size.height/2
            self.animatingView.layer.borderWidth = 3
            self.animatingView.layer.borderColor = UIColor.systemGray5.cgColor

            
            self.imageViewForAnimationView.frame.size.height = 104
            self.imageViewForAnimationView.frame.size.width = 104
            
            self.whiteViewForAnimation.alpha = 0
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            
            self.profileHeaderView.avatarImageView.addSubview(self.profileHeaderView.imageViewInAvatarImageView)
            self.profileHeaderView.avatarImageView.isHidden = false
            self.animatingView.isHidden = true
        })

    }
    
    
    // Эта функция определяет офсет на который "сыграл" навинейшен бар при прокрутке таблицы
    func getPositionOffset() -> CGFloat {
        var valueForReturn: CGFloat = 0
        let cellRect = tableView.rectForRow(at: IndexPath(row: 0, section: 0))
        let y = cellRect.origin.y
        let contentOffset = tableView.contentOffset
        let y_coordinate = y - contentOffset.y // координата ячейки относительно экранных координат
        
        if y_coordinate >= 272 {
            valueForReturn = 22
        }
        if y_coordinate < 272 && y_coordinate >= 250 {
            valueForReturn = y_coordinate - 250
        }
        return valueForReturn
    }
    
}


