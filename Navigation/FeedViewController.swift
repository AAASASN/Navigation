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

        let button = UIButton(frame: CGRect(x: (view.bounds.maxX - 250)/2, y: (view.bounds.maxY - 60)/2, width: 250, height: 60),
                              primaryAction: UIAction(handler: { [self] buttonPressed in
            let postViewController = PostViewController()
            postViewController.localVarPost = post
            self.navigationController?.pushViewController(postViewController, animated: true)
        }))
        
        button.backgroundColor = UIColor(red: 0.99, green: 0.80, blue: 0.00, alpha: 1.00)
        button.layer.borderWidth = CGFloat(2)
        button.layer.borderColor = UIColor(red: 0.07, green: 0.45, blue: 0.87, alpha: 1.00).cgColor
        button.layer.cornerRadius = 10
        button.setTitle("go to PostViewController", for: .normal)
        button.setTitleColor(UIColor(red: 0.07, green: 0.45, blue: 0.87, alpha: 1.00), for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        view.addSubview(button)
    
        
    }

    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
