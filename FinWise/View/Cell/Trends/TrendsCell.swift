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
        imgIcon.image = UIImage(systemName: "bookmark.circle.fill")
    }
    
    func setBorder() {
        viewBg.layer.borderColor = UIColor(red: 237/255, green: 248/255, blue: 95/255, alpha: 1.0).cgColor
        viewBg.layer.borderWidth = 0.5
        viewBg.layer.cornerRadius = 15
        viewBg.layer.shadowRadius = 200
    }
  
    func styleImageIcon() {
        imgIcon.layer.shadowColor = UIColor(red: 237/255, green: 248/255, blue: 95/255, alpha: 1.0).cgColor
        imgIcon.layer.shadowOpacity = 0.3
        imgIcon.layer.shadowOffset = CGSize(width: 2, height: 2)
        imgIcon.layer.shadowRadius = 50
    }

}


