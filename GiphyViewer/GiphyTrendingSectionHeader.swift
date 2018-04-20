//
//  GiphyTrendingSectionHeader.swift
//  GiphyViewer
//
//  Created by Thierry Sansaricq on 4/19/18.
//  Copyright © 2018 Thierry Sansaricq. All rights reserved.
//

import UIKit

class GiphyTrendingSectionHeader: UICollectionReusableView {//}, UIPickerViewDataSource {//}, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var limitSlider: UISlider!
    @IBOutlet weak var ratingPicker: UIPickerView!
    
    
    var pickerViewData = [String]()
    
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "G"
    }
    
}
