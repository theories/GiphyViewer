//
//  TrendingViewController.swift
//  GiphyViewer
//
//  Created by Thierry Sansaricq on 4/19/18.
//  Copyright © 2018 Thierry Sansaricq. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var refreshButton: UIButton!
    lazy var pickerViewData:[String]? = {
        guard let collectionVC = self.collectionVC else {
            return nil
        }
        return collectionVC.pickerViewData
    }()
    
    @IBOutlet weak var pickerView: UIPickerView!
    weak var collectionVC: TrendingCollectionViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "TrendingCollectionViewSegue"){
            collectionVC = segue.destination as? TrendingCollectionViewController
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let pickerData = pickerViewData else {
            return 0
        }
        return pickerData.count
    }
   
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            
            pickerLabel?.font = UIFont(name: "Montserrat", size: 9)
            pickerLabel?.textAlignment = NSTextAlignment.center
            pickerLabel?.textColor = UIColor.white
        }
        
        pickerLabel?.text = pickerViewData?[row] ?? ""
        
        return pickerLabel!;
    }
    
    @IBAction func onRefreshTapped(_ sender: Any) {
        requestGiphyData()
    }
    
    func requestGiphyData() {
        let row = pickerView.selectedRow(inComponent: 0)
       
        if let pickerViewData = self.pickerViewData {
            let rating = pickerViewData[row]
            let params = GiphyAPIParams(rating: rating, limit: 30, queryString: nil)
            collectionVC?.requestGiphyData(params: params)
        }
    }
     
    
}
