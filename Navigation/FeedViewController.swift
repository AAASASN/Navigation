//
//  FeedViewController.swift
//  Navigation
//
//  Created by Александр Мараенко on 23.11.2022.
//

import UIKit

class FeedViewController: UIViewController {

    
    var post = Post()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Присваиваем значение в post
        post.title = "это PostViewController"
        
        view.backgroundColor = UIColor(red: 0.98, green: 0.82, blue: 0.76, alpha: 1.00)
        
        // настройка navigationBar
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 1.00, green: 0.95, blue: 0.74, alpha: 0.67)
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = "FeedViewController"
        self.navigationItem.largeTitleDisplayMode = .always
        
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
         
        
        
        let button1 = UIButton(frame: .zero,
                               primaryAction: UIAction(handler: { [self] _ in
            let postViewController = PostViewController()
            postViewController.localVarPost = post
            self.navigationController?.pushViewController(postViewController, animated: true)
        }))
        
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.backgroundColor = UIColor(red: 0.99, green: 0.80, blue: 0.00, alpha: 1.00)
        button1.layer.borderWidth = CGFloat(2)
        button1.layer.borderColor = UIColor(red: 0.07, green: 0.45, blue: 0.87, alpha: 1.00).cgColor
        button1.layer.cornerRadius = 10
        button1.setTitle("Button1 go to PostViewController ", for: .normal)
        button1.setTitleColor(UIColor(red: 0.07, green: 0.45, blue: 0.87, alpha: 1.00), for: .normal)
        button1.setTitleColor(.white, for: .highlighted)
        stackView.addArrangedSubview(button1)

        
        
        let button2 = UIButton(frame: .zero,
                               primaryAction: UIAction(handler: { [self] buttonPressed in
            let postViewController = PostViewController()
            postViewController.localVarPost = post
            self.navigationController?.pushViewController(postViewController, animated: true)
        }))
        
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.backgroundColor = UIColor(red: 0.99, green: 0.80, blue: 0.00, alpha: 1.00)
        button2.layer.borderWidth = CGFloat(2)
        button2.layer.borderColor = UIColor(red: 0.07, green: 0.45, blue: 0.87, alpha: 1.00).cgColor
        button2.layer.cornerRadius = 10
        button2.setTitle("Button2 go to PostViewController", for: .normal)
        button2.setTitleColor(UIColor(red: 0.07, green: 0.45, blue: 0.87, alpha: 1.00), for: .normal)
        button2.setTitleColor(.white, for: .highlighted)
        stackView.addArrangedSubview(button2)
        
        
        NSLayoutConstraint.activate([stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     button1.heightAnchor.constraint(equalToConstant: 60),
                                     button1.widthAnchor.constraint(equalToConstant: 300),
                                     button2.heightAnchor.constraint(equalToConstant: 60)
                                    ])

    }

}
