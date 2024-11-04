//
//  HeadlineCell.swift
//  FinWise
//
//  Created by IREM SEVER on 4.11.2024.
//

import UIKit

protocol HeadlineNewsCellDelegate: AnyObject {
    func didSelectHeadline(at index: Int)
}

class HeadlineCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var viewCollection: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var viewModel = NewsDetailViewModel()
    
    var index: Int?
    weak var delegate: HeadlineNewsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewCollection.delegate = self
        viewCollection.dataSource = self
        viewCollection.isPagingEnabled = true
        
        viewCollection.register(UINib(nibName: "HeadlineItemCell", bundle: nil), forCellWithReuseIdentifier: "HeadlineItemCell")
        
        if let layout = viewCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.scrollDirection = .horizontal
        }
    }
    
    func configure(with items: [NewsDetailModel], index: Int) {
        self.viewModel.newsList = items
        self.index = index
        
        pageControl.numberOfPages = items.count
        pageControl.currentPage = 0
        
        viewCollection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.newsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadlineItemCell", for: indexPath) as? HeadlineItemCell else {
            return UICollectionViewCell()
        }
        
        let item = viewModel.newsList[indexPath.item]
        cell.configure(with: item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / viewCollection.frame.width)
        pageControl.currentPage = pageIndex
    }
    
    @objc private func handleTap() {
        if let index = index {
            delegate?.didSelectHeadline(at: index)
        }
    }
    
}
