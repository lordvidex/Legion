//
//  MainCollectionViewCell.swift
//  Legion
//
//  Created by Evans Owamoyo on 29.08.2021.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var labelView: UIView!
    
    var storyboardId: String?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor(red: .random(in: 0...1),
                                              green: .random(in: 0...1),
                                              blue: .random(in: 0...1),
                                              alpha: 1)
        // add curves to container
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        // add shadow for label view
        labelView.backgroundColor = .clear
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = labelView.bounds
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        labelView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func updateCellData(title: String, withImage imageName: String?, to storyboardId: String) {
        titleLabel.text = title
        if let imageName = imageName {
            appImageView.image = UIImage(named: imageName)
        }
        self.storyboardId = storyboardId
    }

}
