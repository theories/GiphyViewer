//
//  GiphyImage.swift
//  GiphyAPITest
//
//  Created by Thierry Sansaricq on 4/16/18.
//  Copyright © 2018 Thierry Sansaricq. All rights reserved.
//

import Foundation

struct GiphyImage {
    
    let width: Int?
    let height: Int?
    let url: URL?
    
    init(imageDict: [String: Any]) {
        
        if let width = imageDict["width"] as? Int {
            self.width = width
        }
        else {
            width = nil
        }
        
        if let height = imageDict["height"] as? Int {
            self.height = height
        }
        else {
            height = nil
        }
        
        if let strURL = imageDict["url"] as? String,
            let url = URL(string: strURL) {
            self.url = url
        }
        else {
            url = nil
        }
        
    }
}
