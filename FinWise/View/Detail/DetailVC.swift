//
//  DetailVC.swift
//  FinWise
//
//  Created by İrem Sever on 31.10.2024.
//

import UIKit
import WebKit

class DetailVC: UIViewController {
    var selectedIndex: Int?
    
    @IBOutlet weak var viewWebKit: WKWebView!
    
    private var viewModel = NewsDetailViewModel()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            loadSelectedLink()
            setupSwipeGesture()
        }
        
        private func loadSelectedLink() {
            guard let selectedIndex = selectedIndex,
                  let urlString = viewModel.getLink(for: selectedIndex),
                  let url = URL(string: urlString) else {
                print("URL not found for selected index.")
                return
            }
            
            let request = URLRequest(url: url)
            viewWebKit.load(request)
        }
        
        private func setupSwipeGesture() {
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
            swipeRight.direction = .right // Sağdan sola kaydırma
            view.addGestureRecognizer(swipeRight)
        }
        
        @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
            if gesture.direction == .right {
                navigationController?.popViewController(animated: true) // Ana ekrana dön
            }
        }
    }
