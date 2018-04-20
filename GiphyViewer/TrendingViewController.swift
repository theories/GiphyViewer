//
//  TrendingViewController.swift
//  GiphyViewer
//
//  Created by Thierry Sansaricq on 4/19/18.
//  Copyright © 2018 Thierry Sansaricq. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var limitSlider: UISlider!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var limitTextField: UITextField!
    weak var collectionVC: TrendingCollectionViewController?
    
    lazy var pickerViewData:[String]? = {
        guard let collectionVC = self.collectionVC else {
            return nil
        }
        return collectionVC.pickerViewData
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let index = collectionVC?.giphyDefaultRatingIndex() ?? 0
        pickerView.selectRow(index, inComponent: 0, animated: true)
        limitTextField.text = String(Int(limitSlider.value))

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "TrendingCollectionViewSegue"){
            collectionVC = segue.destination as? TrendingCollectionViewController
        }
    }
    @IBAction func sliderValueChanged(_ sender: Any) {
        limitTextField.text = String(Int(limitSlider.value))
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
    
   
    func refreshData() {
        if let params = giphyParams() {
            collectionVC?.requestGiphyData(params: params)
        }
    }
    
    func giphyParams() -> GiphyAPIParams? {
        let limit = UInt(limitSlider.value)
        let row = pickerView.selectedRow(inComponent: 0)
        if let pickerViewData = self.pickerViewData {
            let rating = pickerViewData[row]
            let params = GiphyAPIParams(rating: rating, limit: limit, queryString: nil)
            return params
        }
        
        return nil
    }
     
    
}
