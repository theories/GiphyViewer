//
//  FakeGiphyAPIManager.swift
//  GiphyViewerTests
//
//  Created by Thierry Sansaricq on 4/27/18.
//  Copyright © 2018 Thierry Sansaricq. All rights reserved.
//

import Foundation


class FakeGiphyAPIManager: GiphyAPIManager {

    let trendingFile:String = "giphy-trending-results"
    let searchFile:String = "giphy-search-results"
    let trendingURL:String = "https://api.giphy.com/v1/gifs/search?api_key=dTYxlzydpneCauqFVT3mnnSteR0M0kwJ&q=Cat&limit=10&offset=0&rating=G&lang=en"
    let searchURL:String = "https://api.giphy.com/v1/gifs/search?api_key=dTYxlzydpneCauqFVT3mnnSteR0M0kwJ&q=Cat&limit=10&offset=0&rating=G&lang=en"
    var sessionMock:URLSessionMock!

    
    override public func search(queryString: String, limit: Int?, offset: Int?, rating: GiphyAPIRating?,  completionHandler: @escaping ([GiphyGif]?, NSError?) -> Void) -> URLSessionDataTask? {
        
        let params: [String : String] = [:]
        
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: searchFile, ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        
        let url = URL(string: searchURL)
        let urlResponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        sessionMock = URLSessionMock(data: data, response: urlResponse, error: nil)

        return loadData(endPoint: GiphyAPIEndpoint.Search, parameters: params, completionHandler: completionHandler)
        
    }
    
    
    override public func trending(limit: Int?, offset: Int?, rating: GiphyAPIRating?,  completionHandler: @escaping ([GiphyGif]?, NSError?) -> Void) -> URLSessionDataTask? {
        let params: [String : String] = [:]
        
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: trendingFile, ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        
        let url = URL(string: trendingURL)
        let urlResponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        sessionMock = URLSessionMock(data: data, response: urlResponse, error: nil)

        return loadData(endPoint: GiphyAPIEndpoint.Trending, parameters: params, completionHandler: completionHandler)
        
    }
    
    override internal func loadData(endPoint: GiphyAPIEndpoint, parameters: [String:String], completionHandler: @escaping ([GiphyGif]?, NSError?) -> Void) -> URLSessionDataTask? {
        
        //var params = parameters
        
        var urlString:String
        
        switch(endPoint){
        case .Trending:
            urlString = trendingURL
        case .Search:
            urlString = searchURL
            
        }
      
        
        guard let requestURL = URL(string: urlString) else {
            let urlError = NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL, userInfo: [NSLocalizedDescriptionKey:"Could not build URL"])
            completionHandler(nil, urlError)
            return nil
        }
        
        let task = sessionMock.dataTask(with: requestURL) {(data, response, error) in
            
            if error != nil {
                //an error occurred
                completionHandler(nil, error as NSError?)
            }
            
            var jsonError:NSError?
            
            do {
                
                if let data = data,
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let meta: [String:Any] = json["meta"] as? [String:Any],
                    let status: Int = meta["status"] as? Int {
                    
                    if status != 200 {
                        
                        let errString = meta["msg"] as? String ?? ""
                        jsonError = NSError(domain: NSURLErrorDomain, code: NSURLErrorBadServerResponse, userInfo: [NSLocalizedDescriptionKey:errString])
                        print("jsonError: \(String(describing: jsonError?.localizedDescription))")
                        completionHandler(nil, jsonError)
                        return
                    }
                    
                    //TODO: add pagination capability
                    
                    var gifArray: [GiphyGif] = []
                    
                    if let gifData = json["data"] as? [[String:Any]] {
                        
                        for gifDict in gifData {
                            gifArray.append(GiphyGif(jsonData: gifDict))
                        }
                        
                    } else if let gif = json["data"] as? [String:Any] {
                        gifArray.append(GiphyGif(jsonData: gif))
                    }
                    
                    completionHandler(gifArray, nil)
                    
                } //end try
                else {
                    //unknown errror
                    let unknownError = NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: [NSLocalizedDescriptionKey:"unknown error"])
                    completionHandler(nil, unknownError)
                }
            } //end do
            catch let jsonError as NSError {
                completionHandler(nil, jsonError)
            }
        } //end task
        
        task.resume()
        return task
        
    }
    
}
