//
//  GiphyCollectionViewCell.swift
//  GiphyViewer
//
//  Created by Thierry Sansaricq on 4/18/18.
//  Copyright © 2018 Thierry Sansaricq. All rights reserved.
//

import UIKit
import SwiftyGif

class GiphyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var imageURL:URL? {
        didSet {
            loadImage(url: imageURL)
        }
    }
    
    func loadImage(url: URL?) {
        if let url = url {
            imageView.setGifFromURL(url)
        }
    }
    
}
