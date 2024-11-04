//
//  HeadlineItemCell.swift
//  FinWise
//
//  Created by IREM SEVER on 4.11.2024.
//

import UIKit
import SDWebImage
class HeadlineItemCell: UICollectionViewCell {
    
    @IBOutlet weak var lblHeadline: UILabel!
    @IBOutlet weak var imgHeadline: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        applyGradient()
    }
    
    func configure(with model: NewsDetailModel) {
        if let urlString = model.thumbnail?.url, let url = URL(string: urlString) {
            imgHeadline.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        }
        
        lblHeadline.text = model.title
    }
    
    func applyGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.withAlphaComponent(1.0).cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.frame = imgHeadline.bounds
        
        imgHeadline.layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let gradientLayer = imgHeadline.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = imgHeadline.bounds
        }
    }
}

