//
//  ViewController.swift
//  FinWise
//
//  Created by IREM SEVER on 22.10.2024.

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, StockNewsCellDelegate, HeadlineNewsCellDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel = FinWiseViewModel()
    private var viewModelStockNews = StockNewsViewModel()
    private var viewModelStockTimeSeries = StockTimeSeriesViewModel()
    private var viewModelNewsDetail = NewsDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.navigationController?.isNavigationBarHidden = true
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        fetchData()
        registerCells()
    }
    
    private func fetchData() {
        viewModel.fetchMarketTrendsData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        viewModelStockTimeSeries.fetchStockTimeSeriesData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        viewModelStockNews.fetchStockNewsData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        viewModelNewsDetail.fetchNewsDetailData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        collectionView.collectionViewLayout = createLayout()
    }
    
    func registerCells() {
        collectionView.register(UINib(nibName: "HeadlineCell", bundle: nil), forCellWithReuseIdentifier: "HeadlineCell")
        collectionView.register(UINib(nibName: "TrendsCell", bundle: nil), forCellWithReuseIdentifier: "TrendsCell")
        collectionView.register(UINib(nibName: "StockTimeSeriesCell", bundle: nil), forCellWithReuseIdentifier: "StockTimeSeriesCell")
        collectionView.register(UINib(nibName: "StockNewsCell", bundle: nil), forCellWithReuseIdentifier: "StockNewsCell")
        collectionView.register(UINib(nibName: "PieChartCell", bundle: nil), forCellWithReuseIdentifier: "PieChartCell")
        collectionView.register(UINib(nibName: "BarChartCell", bundle: nil), forCellWithReuseIdentifier: "BarChartCell")
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .estimated(100))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
                
                return section
            case 1:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(350))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(350))
            
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
          

                return section
            case 2:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                
                return section
                
            case 3:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(200))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
                return section
          
            case 4:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                
                return section
                
            case 5:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .estimated(250))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(250))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
                return section
                
                
            case 6:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                
                return section
                
            default:
                return nil
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return viewModel.numberOfRowsInSection(section: section)
        case 1: return viewModelNewsDetail.numberOfRowsInSection(section: section)
        case 2: return viewModelStockTimeSeries.numberOfRowsInSection(section: section)
        case 3: return viewModelStockNews.numberOfItemsForCase3()
        case 4: return 1
        case 5: return viewModelStockNews.numberOfItemsForCase5()
        case 6: return 1
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendsCell", for: indexPath) as! TrendsCell
            cell.configure(with: viewModel.cellForRowAt(indexPath: indexPath))
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadlineCell", for: indexPath) as! HeadlineCell
            cell.configure(with: viewModelNewsDetail.cellForRowAt(indexPath: indexPath), index: indexPath.item)
            cell.delegate = self
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StockTimeSeriesCell", for: indexPath) as! StockTimeSeriesCell
            cell.configure(with: viewModelStockTimeSeries.cellForRowAt(indexPath: indexPath))
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StockNewsCell", for: indexPath) as! StockNewsCell
            cell.configure(with: viewModelStockNews.cellForRowAt(indexPath: indexPath), index: indexPath.item)
            cell.delegate = self
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BarChartCell", for: indexPath) as! BarChartCell
            cell.configure(with: viewModelStockTimeSeries.cellForRowAt(indexPath: indexPath))
            return cell
        case 5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StockNewsCell", for: indexPath) as! StockNewsCell
            cell.configure(with: viewModelStockNews.cellForRowAt(indexPath: indexPath), index: indexPath.item)
            cell.delegate = self
            return cell
        case 6:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PieChartCell", for: indexPath) as! PieChartCell
            cell.configure(with: viewModelStockTimeSeries.cellForRowAt(indexPath: indexPath))
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func didSelectNews(at index: Int) {
        let detailVC = DetailVC(nibName: "DetailVC", bundle: nil)
        detailVC.selectedIndex = index
        print("index")
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func didSelectHeadline(at index: Int) {
        let detailVC = DetailVC(nibName: "DetailVC", bundle: nil)
        detailVC.selectedIndex = index
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
