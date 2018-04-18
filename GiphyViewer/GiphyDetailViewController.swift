//
//  GiphyDetailViewController.swift
//  GiphyViewer
//
//  Created by Thierry Sansaricq on 4/18/18.
//  Copyright © 2018 Thierry Sansaricq. All rights reserved.
//

import UIKit
import SwiftyGif

class GiphyDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var imageURL:URL?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.label.text = self.villain.name
        if let url = imageURL {
            loadImage(url: url)
        }
    }
    
    func loadImage(url: URL?) {
        if let thisURL = url {
            imageView.setGifFromURL(thisURL)
        }
    }
    
    
   
}
