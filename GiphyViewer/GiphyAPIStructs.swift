//
//  GiphyAPIStructs.swift
//  GiphyViewer
//
//  Created by Thierry Sansaricq on 4/20/18.
//  Copyright © 2018 Thierry Sansaricq. All rights reserved.
//


struct GiphyAPIDefault {
    static let queryString:String = "cat"
    static let limit:UInt = 30
    static let rating:GiphyAPIRating = .G
    static let offset:UInt = 0
}

struct GiphyAPIParams {
    let rating:GiphyAPIRating
    let limit:UInt
    let queryString:String?
}
