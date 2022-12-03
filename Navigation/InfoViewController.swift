//
//  InfoViewController.swift
//  Navigation
//
//  Created by Александр Мараенко on 23.11.2022.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        view.addSubview(addButton())
    }
    

    func showAlertController() -> UIAlertController {
        
        let alertController = UIAlertController(title: "Это title", message: "Это message", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { okPressed in
            print("На АлертКонтроллере нажат ОК")
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { cancelPressed in
            print("На АлертКонтроллере нажат Cancel")
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)

        return alertController
    }
    
    func addButton() -> UIButton{
        
        let button = UIButton(frame: CGRect(x: view.center.x - 250/2,
                                            y: view.center.y - 60/2 ,
                                            width: 250, height: 60),
                              primaryAction: UIAction(handler: { buttonPressed in
            self.present(self.showAlertController(), animated: true)
        }))
        
        button.backgroundColor = UIColor(red: 0.99, green: 0.80, blue: 0.00, alpha: 1.00)
        button.layer.borderWidth = CGFloat(2)
        button.layer.borderColor = UIColor(red: 0.07, green: 0.45, blue: 0.87, alpha: 1.00).cgColor
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor(red: 0.07, green: 0.45, blue: 0.87, alpha: 1.00), for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.setTitle("Нажми меня", for: .normal)
        
        return button
        
    }
}
