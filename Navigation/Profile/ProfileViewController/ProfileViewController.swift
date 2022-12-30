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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSettings()
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
            let profileHeaderView = ProfileHeaderView(frame: .zero)
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


