//
//  MainCollectionViewController.swift
//  Legion
//
//  Created by Evans Owamoyo on 29.08.2021.
//

import UIKit

private let mainCellIdentifier = "MainCollectionViewCell"

class MainCollectionViewController: UICollectionViewController {
    
    let mainCollectionBrain = MainCollectionModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: mainCellIdentifier)
    }
    
    
    // MARK: UICollectionViewDataSource
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainCollectionBrain.screens.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainCellIdentifier, for: indexPath) as? MainCollectionViewCell {
            
            let currentCellData = mainCollectionBrain.screens[indexPath.row]
            
            cell.updateCellData(title: currentCellData.title,
                                withImage: currentCellData.iconName,
                                to: currentCellData.storyBoardId)
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    
    // MARK: Collection delegate methods
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: mainCollectionBrain.screens[indexPath.row].storyBoardId, bundle: nil)
        let newVC = storyboard.instantiateInitialViewController()!
        present(newVC, animated: true, completion: nil)
        //
        
    }
}

// MARK: - UI Collection View Delegate Flow Layout

extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.frame.width
        // subtract left and right paddings with spacings
        let width = (totalWidth - 40) / 2
        return CGSize(width: width, height: width)
    }
}
