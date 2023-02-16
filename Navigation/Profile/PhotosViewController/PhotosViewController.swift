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
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.imageView.image = UIImage(named: photos[indexPath.row])
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        startCollectionCellAnimation(indexPath: indexPath)
    }
    
}

// MARK: - Animation
extension PhotosViewController {
    
    func startCollectionCellAnimation(indexPath: IndexPath) {
        
        // блокируем возможность скрола collectionView
        collectionView.isScrollEnabled = false
        
        // создаем белое вью за которым будут скрываться все элементы расположенные] корневом вью контроллера
        let whiteViewForAnimation = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        whiteViewForAnimation.backgroundColor = .white
        whiteViewForAnimation.alpha = 0
        
        // добавляем ее на view
        self.view.addSubview(whiteViewForAnimation)

        // получаем из collectionView Rect ячейки
        guard var cellRect = collectionView.collectionViewLayout.layoutAttributesForItem(at: indexPath)?.frame else { return }
        
        cellRect.origin.x = cellRect.origin.x + 8
        
        // изменяем координаты Y на view с учетом положения ячейкм в collectionView и navigationBarHeight и тем какой был сделан скрол таблицы
        let navigationBarHeight = self.view.safeAreaLayoutGuide.layoutFrame.origin.y
        cellRect.origin.y = cellRect.origin.y + navigationBarHeight - collectionView.contentOffset.y
        
        // создаем вью которая будет анимироваться
        let someView = UIImageView(frame: cellRect)
        someView.layer.cornerRadius = 5
        someView.clipsToBounds = true
        someView.contentMode = .scaleAspectFill
        
        // добавляем someView на view
        self.view.addSubview(someView)

        // получаем ячейку из collectionView по indexPath, извлекаем из нее картинку и...
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotosCollectionViewCell else { return }
        
        // ...присваем той вью которая будет анимироваться
        someView.image = cell.imageView.image
        
        // кнопка для начала обратной анимации
        let closeButton = {
            let closeButton = UIButton(frame: CGRect(x: self.view.center.x - 50,
                                                     y: self.view.frame.maxY - self.view.frame.maxY/3.5,
                                                     width: 100,
                                                     height: 100))
            closeButton.backgroundColor = .clear
            closeButton.layer.cornerRadius = 20
            
            let imageView = UIImageView(image: UIImage(systemName: "multiply.circle"))
            imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            closeButton.addSubview(imageView)
            closeButton.clipsToBounds = true
            closeButton.alpha = 0
            return closeButton
        }()
        
        // создаем экшен для кнопки
        let closeButtonAction = UIAction { _ in
            
            startReversAnimation()

        }
        
        // добавляем экшен на кнопку
        closeButton.addAction(closeButtonAction, for: .allTouchEvents)

        // скрываем ячейку в collectionView перед началом анимации
        cell.imageView.isHidden = true
        
        //
        UIView.animate(withDuration: 0.3, delay: 0) {
            
            someView.center.y = self.view.center.y - (self.view.center.y) / 3
            someView.center.x = self.view.center.x - (self.view.center.x) / 3 - (self.view.center.x) / 3 + 10

            someView.frame.size.height = someView.frame.size.height * 3
            someView.frame.size.width = someView.frame.size.width * 3
            
            someView.layer.cornerRadius = 10

            whiteViewForAnimation.alpha = 1
        }

        self.view.addSubview(closeButton)
        
        UIView.animate(withDuration: 0.3, delay: 0.3) {
            closeButton.alpha = 1
        }
        
        
        func startReversAnimation() {
            
            // анимация кнопки
            UIView.animate(withDuration: 0.7, delay: 0) {
                closeButton.alpha = 0
            }
            
            // анимация someView
            UIView.animate(withDuration: 0.3, delay: 0.3, animations: {
                
                someView.frame = cellRect
                someView.layer.cornerRadius = 3
                whiteViewForAnimation.alpha = 0
            })
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {

                // отображаем ячейку в collectionView которая была скрыта перед началом анимации
                cell.imageView.isHidden = false

                // удаляем все объкты анимации с view
                someView.removeFromSuperview()
                closeButton.removeFromSuperview()
                whiteViewForAnimation.removeFromSuperview()
                
                // разблокируем возможность скрола collectionView
                self.collectionView.isScrollEnabled = true

            })
        }
    }
}



