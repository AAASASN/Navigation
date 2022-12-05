//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Александр Мараенко on 23.11.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // let profileHeaderView = ProfileHeaderView(frame: CGRect())
     
    var profileHeaderView = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationItem.title = "Profile"
        
        
        
        profileHeaderView = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.maxX), height: Int(self.view.frame.maxY)))
        // в макете указан цвет .gray но по факту это явно .systemGray4 - пришлось сделать systemGray5
        // что бы не сливаться с клавиатурой и не засвечивать цвет текста статуса
        view.backgroundColor = UIColor.systemGray5
        
        //profileHeaderView.frame = view.frame

        view.addSubview(profileHeaderView)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        // profileHeaderView.frame = view.frame
        //profileHeaderView.settings()
    }

}
