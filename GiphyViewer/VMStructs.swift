//
//  struct-enum.swift
//  GiphyViewer
//
//  Created by Thierry Sansaricq on 4/20/18.
//  Copyright © 2018 Thierry Sansaricq. All rights reserved.
//

struct GiphyAPIParams {
    let rating:String?
    let limit:UInt?
    let queryString:String?
}

struct GiphyAPIDefault {
    static let queryString:String = "cat"
    static let limit:UInt = 15
    static let rating:GiphyAPIRating = .G
    static let offset:UInt = 0
}

