//
//  PostViewController.swift
//  Navigation
//
//  Created by Александр Мараенко on 23.11.2022.
//

import UIKit

class PostViewController: UIViewController {

    var localVarPost = SomePost()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0.83, green: 0.77, blue: 0.98, alpha: 1.00)
        
        // помещаем localVarPost.title переданный с FeedViewController контроллера в заголовок
        self.navigationItem.title = localVarPost.title
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.backButtonDisplayMode = .minimal

        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(barButtonItemAction))
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func barButtonItemAction() {
        self.present(createInfoViewController(), animated: true)
    }
    
     func createInfoViewController() -> UIViewController {
        let infoViewController = InfoViewController()
        return infoViewController
    }

}
