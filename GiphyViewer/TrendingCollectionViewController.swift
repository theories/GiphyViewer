//
//  TrendingCollectionViewController.swift
//  GiphyViewer
//
//  Created by Thierry Sansaricq on 4/18/18.
//  Copyright © 2018 Thierry Sansaricq. All rights reserved.
//

import UIKit


class TrendingCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, RemoteDataConsumer { //, UIPickerViewDelegate, UIPickerViewDataSource {
  
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var refreshControl: UIRefreshControl!
 
    private let reuseIdentifier = "GiphyCell"
    private var collectionViewSizeChanged: Bool = false
    private let margin: CGFloat = 14.0
    var pickerViewData:[String]? {
        return viewModel.giphyRatings()
    }

    private var viewModel:GiphyViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupFlowLayout()
        refreshControl = UIRefreshControl()
        if #available(iOS 10.0, *) {
            collectionView?.refreshControl = refreshControl
        }
        else {
            collectionView?.addSubview(refreshControl)
        }

        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attributes)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        viewModel = GiphyViewModel(endPoint: GiphyAPIEndpoint.Trending, delegate: self)
        refreshData()

    }
    

    // MARK: UICollectionViewDataSource
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.count()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // Configure the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as! GiphyCollectionViewCell

        if let imageURL = viewModel.thumbNailImageURL(for: indexPath.row) {
            cell.imageURL = imageURL
        }
        return cell
        
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "GiphyDetailViewController") as! GiphyDetailViewController
        
        //Populate view controller with data from the selected item
        detailController.imageURL = viewModel.downsizedImageURL(for: indexPath.row)
        
        // Present the view controller using navigation
        navigationController!.pushViewController(detailController, animated: true)
    }
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionViewSizeChanged = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if collectionViewSizeChanged {
            collectionView?.collectionViewLayout.invalidateLayout()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if collectionViewSizeChanged {
            collectionViewSizeChanged = false
        }
    }
    
    
    // MARK: UICollectionViewDelegateFlowLayout methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var minColumns:CGFloat = 3.0
        
        if UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation) {
            minColumns = 5.0
        }
        
        let multiplier:CGFloat = minColumns + 1.0
        let rows:CGFloat = CGFloat(viewModel.count()) / minColumns
        let cols:CGFloat = floor(CGFloat(viewModel.count()) / rows)
        
        let width = floor(collectionView.frame.size.width - (multiplier * margin)) / cols
        
        return CGSize(width: width, height: width)
    }
    

   
    
    //MARK: custom methods
    private func setupFlowLayout() {
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: 0.0, right: margin)
    }
    
    @objc private func refreshData(){
    
        if let parentVC = self.parent as? TrendingViewController,
            let params = parentVC.giphyParams() {
            refreshControl.beginRefreshing()
            viewModel.requestGiphyAPITrendingData(params: params)
        }
        else {
            refreshControl.beginRefreshing()
            viewModel.doTrending()
        }

    }
    
    private func updateUI(){
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    
    //MARK: RemoteDataConsumable Protocol Methods
    func onDataReady() {
        updateUI()
    }
    
    func onDataError() {
        //an error occurred loading data
        updateUI()
    }
    
    // MARK: ViewModel communication
    func requestGiphyData(params:GiphyAPIParams) {
        viewModel.requestGiphyAPITrendingData(params: params)
    }
    
    //MARK: Accessors
    
    func giphyDefaultRatingIndex() -> Int? {
        return viewModel.giphyDefaultRatingIndex()
    }
    
}


