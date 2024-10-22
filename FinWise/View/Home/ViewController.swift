//
//  ViewController.swift
//  FinWise
//
//  Created by IREM SEVER on 22.10.2024.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel = FinWiseViewModel()
    private var viewModelStockNews = StockNewsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        fetchMarketTrendsData()
        registerCells()
        
    }
    
    private func fetchMarketTrendsData() {
        viewModel.fetchMarketTrendsData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        collectionView.collectionViewLayout = createLayout()
    }
    
    func registerCells() {
        collectionView.register(UINib(nibName: "TrendsCell", bundle: nil), forCellWithReuseIdentifier: "TrendsCell")
    }
    
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        section.interGroupSpacing = 10
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
}

extension ViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendsCell", for: indexPath) as! TrendsCell
        
        let marketTrend = viewModel.cellForRowAt(indexPath: indexPath)
        
        cell.configure(with: marketTrend)
        
        return cell
    }
}



