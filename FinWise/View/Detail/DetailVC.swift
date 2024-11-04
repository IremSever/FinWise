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
        
        viewModel.fetchNewsDetailData { [weak self] in
            DispatchQueue.main.async {
                self?.loadSelectedLink()
            }
        }
        
        setupSwipeGesture()
    }
    
    private func loadSelectedLink() {
        guard let selectedIndex = selectedIndex,
              let newsModel = viewModel.getNewsModel(for: selectedIndex),
              let url = URL(string: newsModel.link) else {
            print("URL not found for selected index.")
            return
        }
        
        let request = URLRequest(url: url)
        viewWebKit.load(request)
    }
    
    private func setupSwipeGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            navigationController?.popViewController(animated: true)
        }
    }
}

