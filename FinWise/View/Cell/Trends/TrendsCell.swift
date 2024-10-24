//
//  TrendsCell.swift
//  FinWise
//
//  Created by IREM SEVER on 22.10.2024.
//

import UIKit

class TrendsCell: UICollectionViewCell {
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var viewSeperator: UIView!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblChange: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setBorder()
    }
    
    func configure(with trend: MarketTrend) {
        lblName.text = trend.name
        lblValue.text = String(format: "$%.2f", trend.price)
        lblChange.text = String(format: "%.2f (%.2f%%)", trend.change, trend.change_percent)
        lblChange.textColor = trend.change >= 0 ? .green : .red
        viewSeperator.backgroundColor = trend.change >= 0 ? .green : .red
    }
    
    func setBorder() {
        viewBg.layer.borderColor = UIColor.orange.cgColor
        viewBg.layer.borderWidth = 2
        viewBg.layer.cornerRadius = 50
        viewBg.layer.shadowRadius = 200
    }
}


