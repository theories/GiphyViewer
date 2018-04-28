//
//  ViewModelProtocols.swift
//  GiphyViewer
//
//  Created by Thierry Sansaricq on 4/20/18.
//  Copyright © 2018 Thierry Sansaricq. All rights reserved.
//


protocol RemoteDataConsumer: class {
    func onDataReady()
    func onDataError()
}


