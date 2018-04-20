//
//  ViewModel.swift
//  GiphyAPITest
//
//  Created by Thierry Sansaricq on 4/17/18.
//  Copyright © 2018 Thierry Sansaricq. All rights reserved.
//

import Foundation


class GiphyViewModel {

    weak var delegate:RemoteDataConsumer?
    var endPoint:GiphyAPIEndpoint!
    
    var model:[GiphyGif]? {
        didSet {
            //call delegate
            delegate?.onDataReady()
        }
    }
    
    init(endPoint:GiphyAPIEndpoint, delegate: RemoteDataConsumer?) {
        self.endPoint = endPoint
        if let delegate = delegate {
            self.delegate = delegate
        }
    }
    

    func run () {
        
        switch(endPoint) {
        case .Search:
            doSearch()
        case .Trending:
            doTrending()
        case .none: break
        case .some(_): break
            
        }

    }

    
    func doSearch(queryString: String = GiphyAPIDefault.queryString, limit: UInt = GiphyAPIDefault.limit, rating: GiphyAPIRating = GiphyAPIDefault.rating) {
        
        let mgr = GiphyAPIManager(apiKey: "dTYxlzydpneCauqFVT3mnnSteR0M0kwJ")
        
        let _ = mgr.search(queryString: queryString, limit: limit, offset: GiphyAPIDefault.offset, rating: rating, completionHandler: { [weak self] (gifArray, error) in
            if let strongSelf = self {
                strongSelf.onDataLoaded(gifArray: gifArray, error: error)
            }
        })
    }
    
    func doTrending(limit: UInt = GiphyAPIDefault.limit, rating: GiphyAPIRating = GiphyAPIDefault.rating){

        let mgr = GiphyAPIManager(apiKey: "dTYxlzydpneCauqFVT3mnnSteR0M0kwJ")

        let _ = mgr.trending(limit: limit, offset: GiphyAPIDefault.offset, rating: rating, completionHandler: { [weak self] (gifArray, error) in
            if let strongSelf = self {
                strongSelf.onDataLoaded(gifArray: gifArray, error: error)
            }
        })
    }
    
    func onDataLoaded(gifArray: [GiphyGif]?, error: NSError?) {
        if error != nil {
            //an error occurred
            delegate?.onDataError()
            return
        }
        
        if let gifArray = gifArray {
            buildModel(gifArray: gifArray)
        }
    }
    
    func buildModel(gifArray: [GiphyGif]?) {
       if let gifArray = gifArray {
                model = gifArray
        }
    }
    
    func thumbNailImageURL(for index: Int) -> URL? {

        if let gif = giphyGif(for: index),
            let url = gif.imageVariantURL(variant: ImageVariant.PreviewGif){
            return url
        }
        
        return downsizedImageURL(for:index)
    }
    
    func downsizedImageURL(for index: Int) -> URL? {
        
        if let gif = giphyGif(for: index),
            let url = gif.imageVariantURL(variant: ImageVariant.Downsized){
            return url
        }
        
        return nil
    }
    
    
    func giphyGif(for index: Int) -> GiphyGif? {
        
        guard let model = self.model else {
            return nil
        }
        
        if index >= count() {
            return nil
        }
        
        return model[index]
        
    }
    
    func count() -> Int {
        guard let model = self.model else {
            return 0
        }
        return model.count
    }
    
    func giphyRatings() -> [String]{
        return GiphyAPIRating.allValues
    }
    
    func giphyDefaultRatingIndex() -> Int? {
        return giphyRatingsIndex(rating: GiphyAPIDefault.rating)
    }
    
    func giphyRatingsIndex(rating: GiphyAPIRating) -> Int? {
        return giphyRatings().index(of: rating.rawValue)
    }
    
    func requestGiphyAPITrendingData(params:GiphyAPIParams) {
        let strRating = params.rating ?? GiphyAPIDefault.rating.rawValue
        let rating = GiphyAPIRating(rawValue: strRating) ?? GiphyAPIDefault.rating
        let limit = params.limit ?? GiphyAPIDefault.limit
        doTrending(limit: limit, rating: rating)
    }
    
    func requestGiphyAPISearchData(params:GiphyAPIParams) {
        let strRating = params.rating ?? GiphyAPIDefault.rating.rawValue
        let rating = GiphyAPIRating(rawValue: strRating) ?? GiphyAPIDefault.rating
        let limit = params.limit ?? GiphyAPIDefault.limit
        let searchTerm = params.queryString ?? GiphyAPIDefault.queryString
        doSearch(queryString: searchTerm, limit: limit, rating: rating)
        
        // func doSearch(queryString: String = GiphyAPIDefault.queryString, limit: UInt = GiphyAPIDefault.limit, rating: GiphyAPIRating = GiphyAPIDefault.rating) {
        
    }
}
