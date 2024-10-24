//
//  StockNewsCell.swift
//  FinWise
//
//  Created by IREM SEVER on 22.10.2024.
//

import UIKit
import SDWebImage

class StockNewsCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewGradient: UIView!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var imgNews: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        applyGradient()
        setRoundedCorners()
    }
    
    func configure(with stockNews: News) {
        lblTitle.text = stockNews.articleTitle
        
        if let photoURL = URL(string: stockNews.articlePhotoURL) {
            imgNews.sd_setImage(with: photoURL, completed: nil)
        } else {
            imgNews.image = nil
        }
    }
    
    func setRoundedCorners() {
        viewBg.layer.cornerRadius = 20
        viewBg.layer.masksToBounds = true
    }
    
    func applyGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.withAlphaComponent(1.0).cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.frame = imgNews.bounds
        
        imgNews.layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let gradientLayer = imgNews.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = imgNews.bounds
        }
    }
}
