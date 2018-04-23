//
//  struct-enum.swift
//  GiphyViewer
//
//  Created by Thierry Sansaricq on 4/20/18.
//  Copyright © 2018 Thierry Sansaricq. All rights reserved.
//

import Foundation

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

enum EnvironmentVariables: String {
    case API_KEY
    var value: String {
        let key = ProcessInfo.processInfo.environment["GiphyViewer_API_KEY"]
        return key ?? ""
    }
}
