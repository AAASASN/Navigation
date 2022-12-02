//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Александр Мараенко on 23.11.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 1.00, green: 0.95, blue: 0.74, alpha: 0.67)
        self.navigationItem.title = "ProfileViewController"
        self.navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = UIColor(red: 0.75, green: 0.83, blue: 0.95, alpha: 1.00)
    }

}
