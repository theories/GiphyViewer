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

        if let url = imageURL {
            loadImage(url: url)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGesture()
    }
    
    func addGesture() {
     
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(GiphyDetailViewController.handleSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)

    }
    
    
    func loadImage(url: URL?) {
        if let thisURL = url {
            imageView.setGifFromURL(thisURL)
        }
    }
    
    @objc func handleSwipeGesture(_ gesture: UIGestureRecognizer) {
        _ = self.navigationController?.popViewController(animated: true)
       
    }
    
    
   
}
