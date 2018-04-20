//
//  GiphyGif.swift
//  GiphyAPITest
//
//  Created by Thierry Sansaricq on 4/16/18.
//  Copyright © 2018 Thierry Sansaricq. All rights reserved.
//

import Foundation

class GiphyGif {
    
    let json:[String: Any]
    
    var id:String {
        guard let id = json["id"] as? String else {
            return ""
        }
        return id
    }
    
    var title:String {
        guard let title = json["title"] as? String else {
            return ""
        }
        return title
    }

    var url:URL? {
        guard let strURL = json["url"] as? String else {
            return nil
        }
        
        if let url = URL(string: strURL) {
            return url
        }
        return nil
    }
    
    
    var slug:String {
        guard let slug = json["slug"] as? String else {
            return ""
        }
        return slug
    }
    
    var rating:String {
        guard let rating = json["rating"] as? String else {
            return ""
        }
        return rating
    }
    
    
    var images:[String:Any]? {
        guard let images = json["images"] as? [String: Any] else {
            return nil
        }
        
        return images
    }
    
    init(jsonData: [String:Any]) {
        json = jsonData
    }
    
    func imageVariantURL(variant: ImageVariant) -> URL? {
        if let urlStr = imageVariantURLString(variant: variant) {
            return URL(string: urlStr)
        }
        
        return nil
    }
    
    func imageVariantURLString(variant: ImageVariant) -> String? {
        if let images = self.images,
            let imgVariant = images[variant.rawValue] as? [String: Any],
            let url = imgVariant["url"] as? String {
            return url
        }
        
        return nil
        
    }
    
    
    
    
}



public enum ImageVariant: String {
    case FixeHeightStill = "fixed_height_still"
    case OriginalStill = "original_still"
    case FixedWidth = "fixed_width"
    case FixedHeightSmallStill = "fixed_height_small_still"
    case FixedHeightDownsampled = "fixed_height_downsampled"
    case Preview = "preview"
    case FixedHeightSmall = "fixed_height_small"
    case DownsizedStill = "downsized_still"
    case Downsized = "downsized"
    case DownsizedLarge = "downsized_large"
    case FixedWidthSmallStill = "fixed_width_small_still"
    case PreviewWebp = "preview_webp"
    case FixedWidthStill = "fixed_width_still"
    case FixedWidthSmall = "fixed_width_small"
    case DownsizedSmall = "downsized_small"
    case FixedWidthDownsampled = "fixed_width_downsampled"
    case DownsizedMedium = "downsized_medium"
    case Looping = "looping"
    case OriginalMP4 = "original_mp4"
    case PreviewGif = "preview_gif"
    case Still480w = "480w_still"
    case FixedHeight = "fixed_height"
    case Original = "original"
}


