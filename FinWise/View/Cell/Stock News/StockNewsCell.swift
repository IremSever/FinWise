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
    }
    
    
    func configure(with stockNews: News) {
        lblTitle.text = stockNews.articleTitle
        if let photoURL = URL(string: stockNews.articlePhotoURL) {
            imgNews.sd_setImage(with: photoURL, completed: nil)
        } else {
            imgNews.image = nil 
        }
    }
    
    func applyGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = viewGradient.bounds
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        
        viewGradient.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewGradient.layer.sublayers?.first?.frame = viewGradient.bounds
    }
    
}
