//
//  LoginViewController.swift
//  FinWise
//
//  Created by İrem Sever on 25.10.2024.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var heightViewWhite: NSLayoutConstraint!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var viewBlack: UIView!
    @IBOutlet weak var viewWhite: UIView!
    @IBOutlet var viewBg: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Login Page")
        
        setupDesign()
        view.layoutIfNeeded()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupBlackView()
    }
    
    
    func setupDesign() {
        viewBg.backgroundColor = UIColor(red: 237/255, green: 248/255, blue: 95/255, alpha: 1.0)
        
        setupBlackView()
        setupWhiteView()
        setupAutoLayoutConstraints()
        setupPieChart()
        
        setupTextAndButton()
    }
    func setupAutoLayoutConstraints() {
        viewWhite.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewWhite.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            viewWhite.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            viewWhite.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            viewWhite.heightAnchor.constraint(equalToConstant: 234)
        ])
        
        viewBlack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewBlack.topAnchor.constraint(equalTo: self.view.topAnchor),
            viewBlack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            viewBlack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            viewBlack.bottomAnchor.constraint(equalTo: viewWhite.topAnchor)
        ])
    }
    
    func setupBlackView() {
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: viewBlack.bounds,
                                byRoundingCorners: [.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: viewBlack.frame.width / 2, height: viewBlack.frame.width / 2))
        maskLayer.path = path.cgPath
        viewBlack.layer.mask = maskLayer
    }
    
    func setupWhiteView() {
        viewWhite.layer.cornerRadius = 160
        viewWhite.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewWhite.layer.masksToBounds = true
    }
    
    func setupPieChart() {
        let pieLayer = CAShapeLayer()
        let center = CGPoint(x: viewBlack.frame.width / 2, y: viewBlack.frame.height / 2)
        let radius: CGFloat = 50
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = (11 * .pi) / 6
        
        let piePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        piePath.addLine(to: center)
        piePath.close()
        
        pieLayer.path = piePath.cgPath
        pieLayer.fillColor = UIColor.white.cgColor
        
        viewBlack.layer.addSublayer(pieLayer)
        
        let yellowCircleLayer = CAShapeLayer()
        let yellowCirclePath = UIBezierPath(arcCenter: CGPoint(x: center.x + radius * cos(endAngle), y: center.y + radius * sin(endAngle)), radius: 10, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        
        yellowCircleLayer.path = yellowCirclePath.cgPath
        yellowCircleLayer.fillColor = UIColor(red: 237/255, green: 248/255, blue: 95/255, alpha: 1.0).cgColor
        
        viewBlack.layer.addSublayer(yellowCircleLayer)
        
        let diamondLayer = CAShapeLayer()
        let diamondPath = UIBezierPath()
        
        let diamondWidth: CGFloat = 30
        diamondPath.move(to: CGPoint(x: viewBg.frame.width * 0.8, y: viewBg.frame.height * 0.15))
        diamondPath.addLine(to: CGPoint(x: viewBg.frame.width * 0.8 + diamondWidth / 2, y: viewBg.frame.height * 0.15 + diamondWidth / 2))
        diamondPath.addLine(to: CGPoint(x: viewBg.frame.width * 0.8, y: viewBg.frame.height * 0.15 + diamondWidth))
        diamondPath.addLine(to: CGPoint(x: viewBg.frame.width * 0.8 - diamondWidth / 2, y: viewBg.frame.height * 0.15 + diamondWidth / 2))
        diamondPath.close()
        
        diamondLayer.path = diamondPath.cgPath
        diamondLayer.fillColor = UIColor(red: 203/255, green: 190/255, blue: 247/255, alpha: 1.0).cgColor
        
        viewBg.layer.addSublayer(diamondLayer)
        
        
    }
    
    func setupTextAndButton() {
        let titleLabel = UILabel()
        titleLabel.text = "Manage\nYour Finance\nRight Now"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 40)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        viewBlack.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: viewBlack.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: viewBlack.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: viewBlack.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: viewBlack.trailingAnchor, constant: -20)
        ])
        
        buttonLogin.layer.cornerRadius = buttonLogin.frame.height / 2
        buttonLogin.backgroundColor = .black
        buttonLogin.setTitle("", for: .normal)
        buttonLogin.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        buttonLogin.tintColor = .white
    }
    
    
    @IBAction func buttonLogin(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        navigationController?.pushViewController(homeViewController, animated: true)
    }
}
