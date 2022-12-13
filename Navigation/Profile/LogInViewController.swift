//
//  LogInViewController.swift
//  Navigation
//
//  Created by Александр Мараенко on 12.12.2022.
//

import Foundation
import UIKit

class LogInViewController: UIViewController {
     
    var scrollView = MyScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        // self.navigationController?.navigationBar.isHidden = true

        scrollView.settings()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            scrollView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        scrollView.button.addAction(UIAction(handler: { _ in
            let profileViewController = ProfileViewController()
            self.navigationController?.pushViewController(profileViewController, animated: true)
        }), for: .touchUpInside)
        
        registerForKeyboardNotifications()
        
        // self.scrollView.contentSize = CGSize(width: view.frame.maxX, height: view.frame.maxY + 100)

    }
}

// это расширение возволяет скрыть клавиатуру при косании вне TextView или TextField.
// Данное решение подходит для случая когда TextView или TextField расположены внутри ScrollView
extension LogInViewController {
    
    // активируем режим отслеживания нажатия на scrollView
    func hideKeyboard() {
        //
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        scrollView.addGestureRecognizer(tap)
    }

    // скрываем клавиатуру с scrollView и удаляем gestureRecognizers что бы scrollView работал в обычном режиме
    @objc func dismissKeyboard() {
        // скрываем клавиатуру
        scrollView.endEditing(true)
    }
    

    // этот метод будет вызван в viewDidLoad, он регистрирует наблюдателей которые...
    func registerForKeyboardNotifications() {
        
        // ... будет реагировать на появление клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // ... будет реагировать на начало изчезновения клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // ... будет реагировать после изчезновения клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        
    }
    
    // удаление наблюдателей когда они уже не нужны
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // функция вычисляет размер сдвига и обращась к scrollView задает растояние сдвига contentOffset
    @objc func kbWillShow(_ notification: Notification) {
        
        // запрашиваем параметры клавиатуры
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        // сдвигаем tableView на contentOffset
        scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height - 80 )
        
        // в тот момент когда появилась клавиатура зарегистрируем нажатие UITapGestureRecognizer
        hideKeyboard()
    }
    
    // функция обращась к tableView задает растояние сдвига contentOffset равное 0
    @objc func kbWillHide() {
        scrollView.contentOffset = CGPoint(x: 0, y: 0) // CGPoint.zero
    }
    
    @objc func kbDidHide() {
        // удаляем все экзкмпляры UITapGestureRecognizer которые привязаны к scrollView
        scrollView.gestureRecognizers?.forEach(scrollView.removeGestureRecognizer)
    }
    
}
