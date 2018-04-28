//
//  GiphyViewerTests.swift
//  GiphyViewerTests
//
//  Created by Thierry Sansaricq on 4/15/18.
//  Copyright © 2018 Thierry Sansaricq. All rights reserved.
//

import XCTest
@testable import GiphyViewer


class GiphyViewModelTests: XCTestCase {
  
    
    var viewModel:GiphyViewModel!
    var promise:XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSearchResultsParsesData(){
        
        /*
         * acknowledgement to:
         * http://www.mokacoding.com/blog/testing-delegates-in-swift-with-xctest/
         * for the spy delegate pattern
         */
        
        let apiManager = FakeGiphyAPIManager(apiKey: "") as GiphyAPIManager
        let spyDelegate = RemoteDataConsumerSpyDelegate()
        let vm = GiphyViewModel(endPoint: GiphyAPIEndpoint.Search, delegate: spyDelegate, apiManager: apiManager)
        
        promise = expectation(description: "onDataReady() will be called on spy delegate")
        spyDelegate.asyncExpectation = promise
        vm.doSearch()
        
        waitForExpectations(timeout: 5) { error in

            guard let _ = spyDelegate.dataReadyCalled else {
                XCTFail("Expected delegate to be called")
                return
            }
            
            let numParsed = vm.count()
            XCTAssertEqual(numParsed, 10)

        }
    }
    
    func testTrendingResultsParsesData(){
        
        let apiManager = FakeGiphyAPIManager(apiKey: "") as GiphyAPIManager
        let spyDelegate = RemoteDataConsumerSpyDelegate()
        let vm = GiphyViewModel(endPoint: GiphyAPIEndpoint.Trending, delegate: spyDelegate, apiManager: apiManager)
        
        promise = expectation(description: "onDataReady() will be called on spy delegate")
        spyDelegate.asyncExpectation = promise
        vm.doTrending()
        
        waitForExpectations(timeout: 5) { error in
            
            guard let _ = spyDelegate.dataReadyCalled else {
                XCTFail("Expected delegate to be called")
                return
            }
            
            let numParsed = vm.count()
            XCTAssertEqual(numParsed, 10)
        }
    }

    
}
