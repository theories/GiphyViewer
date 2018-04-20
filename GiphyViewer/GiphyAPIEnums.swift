//
//  GiphyAPIEnums.swift
//  GiphyViewer
//
//  Created by Thierry Sansaricq on 4/20/18.
//  Copyright © 2018 Thierry Sansaricq. All rights reserved.
//



public enum GiphyAPIRating: String {
    case Y = "Y"
    case G = "G"
    case PG = "PG"
    case PG13 = "PG-13"
    case R = "R"
    
    static let allValues = [GiphyAPIRating.Y.rawValue, GiphyAPIRating.G.rawValue, GiphyAPIRating.PG.rawValue, GiphyAPIRating.PG13.rawValue, GiphyAPIRating.R.rawValue]
    
}

public enum GiphyAPIEndpoint: String {
    case Search = "search"
    case Trending = "trending"
}
