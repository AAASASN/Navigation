//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Александр Мараенко on 29.12.2022.
//

import UIKit

class PhotosViewController: UIViewController {

    var collectionView: UICollectionView!
    var photos: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationItem.title = "Photo Gallery"
        
        collectionViewSettings()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    

    func collectionViewSettings()  {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: (view.bounds.width - 32) / 3, height: 68)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        self.collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "id")
    }

}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell()
        }
        cell.imageView.image = UIImage(named: photos[indexPath.row])
        return cell
    }
    
    
}
