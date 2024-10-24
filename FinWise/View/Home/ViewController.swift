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
    private var viewModelStockTimeSeries = StockTimeSeriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        fetchData()
        registerCells()
    }
    
    private func fetchData() {
        viewModel.fetchMarketTrendsData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        viewModelStockNews.fetchStockNewsData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        viewModelStockTimeSeries.fetchStockTimeSeriesData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        collectionView.collectionViewLayout = createLayout()
    }
    
    func registerCells() {
        collectionView.register(UINib(nibName: "TrendsCell", bundle: nil), forCellWithReuseIdentifier: "TrendsCell")
        collectionView.register(UINib(nibName: "StockNewsCell", bundle: nil), forCellWithReuseIdentifier: "StockNewsCell")
        collectionView.register(UINib(nibName: "StockTimeSeriesCell", bundle: nil), forCellWithReuseIdentifier: "StockTimeSeriesCell")
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .estimated(180))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(180))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                section.interGroupSpacing = 8
                section.orthogonalScrollingBehavior = .continuous
                
                return section
                
            case 1:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(268))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(268))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 2)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                section.interGroupSpacing = 8
                
                return section
                
            case 2:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                
                return section
                
            default:
                return nil
            }
        }
    }


    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if section == 0 {
                return viewModel.numberOfRowsInSection(section: section)
            } else if section == 1 {
                return viewModelStockNews.numberOfRowsInSection(section: section)
            } else if section == 2 {
                return viewModelStockTimeSeries.numberOfRowsInSection(section: section)
            }
            return 0
        }

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendsCell", for: indexPath) as! TrendsCell
            let marketTrend = viewModel.cellForRowAt(indexPath: indexPath)
            cell.configure(with: marketTrend)
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StockNewsCell", for: indexPath) as! StockNewsCell
            let stockNews = viewModelStockNews.cellForRowAt(indexPath: indexPath)
            cell.configure(with: stockNews)
            return cell
        } else  if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StockTimeSeriesCell", for: indexPath) as! StockTimeSeriesCell
            let timeSeriesData = viewModelStockTimeSeries.cellForRowAt(indexPath: indexPath)
            cell.configure(with: timeSeriesData)
            
            return cell
        }
        else {
            return UICollectionViewCell()
        }
            
    }
}
