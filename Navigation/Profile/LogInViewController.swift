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
    var tap: UITapGestureRecognizer! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        scrollView.settings()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        scrollView.button.addAction(UIAction(handler: { _ in
            let profileViewController = ProfileViewController()
            self.navigationController?.pushViewController(profileViewController, animated: true)
        }), for: .touchUpInside)
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.maxX - self.view.safeAreaInsets.left - self.view.safeAreaInsets.right, height: 522 - self.view.safeAreaInsets.top)
        
        registerForKeyboardNotifications()
        
        tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.maxX - self.view.safeAreaInsets.left - self.view.safeAreaInsets.right, height: 522)
        
        viewWillLayoutSubviews()
    }
    
}

// это расширение возволяет скрыть клавиатуру при косании вне TextView или TextField.
// Данное решение подходит для случая когда TextView или TextField расположены внутри ScrollView
extension LogInViewController {

    // активируем режим отслеживания нажатия на scrollView
    func registerTapGestureRecognizerForHideKeyboard() {
        scrollView.addGestureRecognizer(tap)
        viewWillLayoutSubviews()
    }

    // скрываем клавиатуру с scrollView и удаляем gestureRecognizers что бы scrollView работал в обычном режиме
    @objc func dismissKeyboard() {
        // скрываем клавиатуру
        scrollView.endEditing(true)
        scrollView.removeGestureRecognizer(tap)
    }


    // этот метод будет вызван в viewDidLoad, он регистрирует наблюдателей которые...
    func registerForKeyboardNotifications() {

        // ... будет реагировать на появление клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        // ... будет реагировать на начало изчезновения клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }

    // функция вычисляет размер сдвига и обращась к scrollView задает растояние сдвига contentOffset
    @objc func kbWillShow(_ notification: Notification) {

        // запрашиваем параметры клавиатуры
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

        // сдвигаем tableView на contentOffset минус некоторое значение зависящее от
        // размера экрана
        let yValue = 522 + kbFrameSize.height - view.frame.maxY
        scrollView.contentOffset = CGPoint(x: 0, y: yValue)

        // в тот момент когда появилась клавиатура зарегистрируем нажатие UITapGestureRecognizer
        registerTapGestureRecognizerForHideKeyboard()

    }

    // функция обращась к tableView задает растояние сдвига contentOffset равное 0
    @objc func kbWillHide() {
        // сдвигаем tableView на contentOffset
        scrollView.contentOffset = CGPoint(x: 0, y: -self.view.safeAreaInsets.top)
    }

}
