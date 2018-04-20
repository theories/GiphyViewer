//
//  GiphyAPManager.swift
//  GiphyAPITest
//
//  Created by Thierry Sansaricq on 4/16/18.
//  Copyright © 2018 Thierry Sansaricq. All rights reserved.
//

import Foundation

class GiphyAPIManager {

    static let BaseURL = "https://api.giphy.com/v1/gifs"
    
    let apiKey:String
    let session:URLSession
    
    public init(apiKey key: String) {
        session = URLSession.shared
        apiKey = key
    }
    

    
    public func search(queryString: String, limit: UInt?, offset: UInt?, rating: GiphyAPIRating?,  completionHandler: @escaping ([GiphyGif]?, NSError?) -> Void) -> URLSessionDataTask? {
    
        var params: [String : Any] = ["q":queryString as Any]
        
        if let thisLimit = limit {
            params["limit"] = thisLimit as Any
        }
        
        if let thisOffset = offset {
            params["offset"] = thisOffset as Any
        }
        
        if let thisRating = rating {
            params["rating"] = thisRating.rawValue as Any
        }
    
        return loadData(endPoint: GiphyAPIEndpoint.Search, parameters: params, completionHandler: completionHandler)
    
    }
    
    public func trending(limit: UInt?, offset: UInt?, rating: GiphyAPIRating?,  completionHandler: @escaping ([GiphyGif]?, NSError?) -> Void) -> URLSessionDataTask? {
        
        var params: [String : Any] = [:]
        
        if let thisLimit = limit {
            params["limit"] = thisLimit as Any
        }
        
        if let thisOffset = offset {
            params["offset"] = thisOffset as Any
        }
        
        if let thisRating = rating {
            params["rating"] = thisRating.rawValue as Any
        }
        
        return loadData(endPoint: GiphyAPIEndpoint.Trending, parameters: params, completionHandler: completionHandler)
        
    }
    
    
    private func loadData(endPoint: GiphyAPIEndpoint, parameters: [String:Any], completionHandler: @escaping ([GiphyGif]?, NSError?) -> Void) -> URLSessionDataTask? {
        
        var params = parameters
        var urlString = (GiphyAPIManager.BaseURL as NSString).appendingPathComponent(endPoint.rawValue)
        
        params["api_key"] = apiKey as Any
        
        urlString += "?"
        
        var i = 0
        for (key, value) in params {
            if let encodedKey = key.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
                let encodedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
                urlString += encodedKey
                urlString += "="
                urlString += encodedValue
            }
            
            if (i != params.count - 1) {
                urlString += "&"
            }
            
            i += 1
            
        }
        
        guard let requestURL = URL(string: urlString) else {
            let urlError = NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL, userInfo: [NSLocalizedDescriptionKey:"Could not build URL"])
            completionHandler(nil, urlError)
            return nil
        }
        
        let task = session.dataTask(with: requestURL) {(data, response, error) in
            
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



