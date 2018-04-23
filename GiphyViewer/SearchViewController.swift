//
//  TrendingViewController.swift
//  GiphyViewer
//
//  Created by Thierry Sansaricq on 4/19/18.
//  Copyright © 2018 Thierry Sansaricq. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UISearchBarDelegate {
  
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var limitSlider: UISlider!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var errorTextField: UITextField!
    
    @IBOutlet weak var limitTextField: UITextField!
    weak var collectionVC: SearchCollectionViewController?
    
    lazy var pickerViewData:[String]? = {
        guard let collectionVC = self.collectionVC else {
            return nil
        }
        return collectionVC.pickerViewData
    }()
    
    //UIViewController related methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let index = collectionVC?.giphyDefaultRatingIndex() ?? 0
        pickerView.selectRow(index, inComponent: 0, animated: true)
        limitTextField.text = String(Int(limitSlider.value))

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "TrendingCollectionViewSegue"){
            collectionVC = segue.destination as? SearchCollectionViewController
        }
    }
    @IBAction func sliderValueChanged(_ sender: Any) {
        limitTextField.text = String(Int(limitSlider.value))
    }
    
    func showError(isHidden: Bool, str:String?) {
        
        if let str = str {
            self.errorTextField.text = str
        }
        
        self.errorTextField.isHidden = isHidden
    }
    
    
    // MARK: PickerView
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
    
    // MARK: Search Bar

    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        
        let views = searchBar.subviews[0]
        for subView in views.subviews {
            if let element = subView as? UIButton {
                element.setTitleColor(UIColor.black, for: .normal)
            }
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        refreshData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
   
    func refreshData() {
        if let params = giphyParams() {
            showError(isHidden: true, str: "")
            collectionVC?.requestGiphyData(params: params)
        }
    }
    
    func giphyParams() -> GiphyAPIParams? {
        var queryString:String? = nil
        
        if let searchTerm = searchBar.text,
            !searchTerm.isEmpty {
            queryString = searchTerm
        }

        let limit = UInt(limitSlider.value)
        let row = pickerView.selectedRow(inComponent: 0)
        if let pickerViewData = self.pickerViewData {
            let rating = pickerViewData[row]
            let params = GiphyAPIParams(rating: rating, limit: limit, queryString: queryString)
            return params
        }
        
        return nil
    }
    
    

    
}

extension SearchViewController: RemoteDataConsumer {
    //MARK: RemoteDataConsumer protocol methods
    func onDataReady() {
        DispatchQueue.main.async  {
            self.showError(isHidden: true, str: "")
        }
    }
    
    func onDataError() {
        DispatchQueue.main.async  {
            self.showError(isHidden: false, str: "Error loading data!")
        }
    }
    
}
