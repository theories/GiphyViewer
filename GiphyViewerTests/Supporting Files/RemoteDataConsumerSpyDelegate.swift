//
//  RemoteDataConsumerSpyDelegate.swift
//  GiphyViewer
//
//  Created by Thierry Sansaricq on 4/27/18.
//  Copyright © 2018 Thierry Sansaricq. All rights reserved.
//
/*
 * acknowledgement to:
 * http://www.mokacoding.com/blog/testing-delegates-in-swift-with-xctest/
 * for the spy delegate pattern
 */

import Foundation
import XCTest
@testable import GiphyViewer

class RemoteDataConsumerSpyDelegate: RemoteDataConsumer {
    
    var dataReadyCalled:Bool? = .none
    var dataErrorCalled:Bool? = .none
    var asyncExpectation: XCTestExpectation?

    
    func onDataError() {
        //called onDataError()
        dataErrorCalled = true
    }
    
    // Setting .None is unnecessary, but helps with clarity imho

    
    // Async test code needs to fulfill the XCTestExpecation used for the test
    // when all the async operations have been completed. For this reason we need
    // to store a reference to the expectation

    
    func onDataReady() {
        
        print("delegate wasvcalled!")
        guard let expectation = asyncExpectation else {
            XCTFail("SpyDelegate was not setup correctly. Missing XCTExpectation reference")
            return
        }
        
        dataReadyCalled = true
        expectation.fulfill()
    }
    
}
