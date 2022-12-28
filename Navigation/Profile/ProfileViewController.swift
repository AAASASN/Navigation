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
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationItem.title = "Profile"
        
        postArray = createPostArray()
        
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                                    ])
        
        tableView.backgroundColor = .white
        tableView.separatorInset.left = .zero

        tableView.delegate = self
        tableView.dataSource = self
        
        tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardNotifications()
    }
    
}



// MARK: - UITableViewDelegate  UITableViewDataSource
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PostTableViewCell()
        cell.cellSetting()
        cell.authorLabel.text = postArray[indexPath.row].author
        cell.imageViewForPicture.image = UIImage(named: postArray[indexPath.row].image)
        cell.descriptionLabel.text = postArray[indexPath.row].description
        cell.likesLabel.text = "Likes: \(postArray[indexPath.row].likes)" 
        cell.viewsLabel.text = "Views: \(postArray[indexPath.row].views)"

        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let profileHeaderView = ProfileHeaderView(frame: .zero)
        profileHeaderView.backgroundColor = .white
        return  profileHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    
}

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



// MARK: - createPostArray()
extension ProfileViewController {
    
    func createPostArray() -> [Post] {
        var postArray = [Post]()
        let post1 = Post(author: "Яндекс",
                         description: "Яндекс круглый год приглашает студентов и выпускников вузов поучаствовать в программе стажировки. Можно от 3 до 6 месяцев работать над важными и сложными задачами вместе с коллегами в Яндексе, чтобы набраться опыта. И получить возможность стать сотрудником в штате.",
                         image: "yandex",
                         likes: 6,
                         views: 15)
        
        let post2 = Post(author: "ВКонтакте",
                         description: "Стажировка в VK — твой пропуск в нашу экосистему. Мы верим в тебя и готовы делиться проектами и задачами. На два-три месяца ты станешь частью VK и разберёшься, как у нас всё устроено.",
                         image: "vk",
                         likes: 2,
                         views: 134)
        
        let post3 = Post(author: "Тинькофф",
                         description: "В АНО ДПО «Тинькофф Образование» реализуются образовательные программы дополнительного образования. Нормативные сроки обучения предусмотрены учебными планами образовательных программ. Государственная аккредитация образовательных программ не предусмотрена. Обучение осуществляется на русском языке. Учебные и методические материалы по конкретным образовательным программам (их частям) могут быть изложены на английском языке. Возможность использования электронного обучения и дистанционных образовательных технологий устанавливается образовательными программами. Обучение за счет бюджетных ассигнований федерального бюджета, бюджетов субъектов Российской Федерации, местных бюджетов не предусмотрено.",
                         image: "tinkoff",
                         likes: 7, views: 54)
        
        let post4 = Post(author: "OZON",
                         description: "Ozon Camp - это программа оплачиваемых стажировок на космических скоростях, где ты поработаешь над эпичными проектами в команде настоящих профи. Выбирай подходящее направление и бегом в e-com!",
                         image: "ozon",
                         likes: 4,
                         views: 34)
        
        let post5 = Post(author: "Сбербанк", description: "«Не бойтесь пробовать и используйте любую возможность, которая вам даётся. Вы можете даже не догадываться, сколько дверей она сможет открыть перед вами»",
                         image: "sber",
                         likes: 31,
                         views: 224)
        
        postArray.append(post1)
        postArray.append(post2)
        postArray.append(post3)
        postArray.append(post4)
        postArray.append(post5)
        
        return postArray
    }
}
