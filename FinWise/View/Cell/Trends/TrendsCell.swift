//
//  TrendsCell.swift
//  FinWise
//
//  Created by IREM SEVER on 22.10.2024.
//

import UIKit

class TrendsCell: UICollectionViewCell {
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblChange: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setBorder()
        styleImageIcon()
    }
    
    func configure(with trend: MarketTrend) {
        lblName.text = trend.name
        lblValue.text = String(format: "$%.2f", trend.price)
        lblChange.text = String(format: "%.2f (%.2f%%)", trend.change, trend.change_percent)
        lblChange.textColor = trend.change >= 0 ? .green : .red
        imgIcon.image = UIImage(systemName: "star")
    }
    
    func setBorder() {
        viewBg.layer.borderColor = UIColor.orange.cgColor
        viewBg.layer.borderWidth = 0.5
        viewBg.layer.cornerRadius = 15
        viewBg.layer.shadowRadius = 200
    }
  
    func styleImageIcon() {
        imgIcon.layer.cornerRadius = imgIcon.frame.height / 2
        imgIcon.clipsToBounds = true
        
        imgIcon.layer.shadowColor = UIColor.black.cgColor
        imgIcon.layer.shadowOpacity = 0.3
        imgIcon.layer.shadowOffset = CGSize(width: 2, height: 2)
        imgIcon.layer.shadowRadius = 4
        
        imgIcon.layer.borderWidth = 1
        imgIcon.layer.borderColor = UIColor.lightGray.cgColor
    }

}


