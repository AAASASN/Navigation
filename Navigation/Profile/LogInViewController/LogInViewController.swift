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
            
            // вариант при котором горизонтальный режим выгрядит хорошо, но нет реакции при нажатии
            // на текстФилды и кнопку
//            scrollView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
//            scrollView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor)
            
            // вариант при котором горизонтальный режим выгрядит плохо и есть заступы за сейфэрию, но
            // при нажатии на текстФилды появляется клавиатура но не работает кнопка
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: view.safeAreaInsets.top),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: view.safeAreaInsets.left),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: view.safeAreaInsets.right),
            scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
            

            
        ])
        
        
        scrollView.button.addAction(UIAction(handler: { _ in
            if self.scrollView.checkLoginAndPass() {
                
                let profileViewController = ProfileViewController()
                self.navigationController?.pushViewController(profileViewController, animated: true)
                
            }

        }), for: .touchUpInside)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        registerForKeyboardNotifications()
        
        viewWillLayoutSubviews()

        // при первом отображении экрана отсупы сейфЭрии всегда по нулям
        
        print("Screen viewWillAppear ")
        print("top = \(self.view.safeAreaInsets.top)")
        print("bottom = \(self.view.safeAreaInsets.bottom)")
        print("left = \(self.view.safeAreaInsets.left)")
        print("right = \(self.view.safeAreaInsets.right)")
        
        self.navigationController?.navigationBar.isHidden = true
        self.scrollView.contentSize = CGSize(width: self.view.frame.maxX, height: 522 - self.view.safeAreaInsets.top)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardNotifications()
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        
        // при повороте экрана отступы сейфЭрии высчитываются коректно
        print("Screen didRotate ")
        print("top = \(self.view.safeAreaInsets.top)")
        print("bottom = \(self.view.safeAreaInsets.bottom)")
        print("left = \(self.view.safeAreaInsets.left)")
        print("right = \(self.view.safeAreaInsets.right)")

        self.scrollView.contentSize = CGSize(width: self.view.frame.maxX - self.view.safeAreaInsets.left - self.view.safeAreaInsets.right, height: 522 - self.view.safeAreaInsets.top)
        
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
