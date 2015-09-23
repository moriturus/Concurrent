//
//  Sendable.swift
//  Concurrent
//
//  Created by moriturus on 8/12/14.
//  Copyright (c) 2014-2015 moriturus. All rights reserved.
//

public protocol Sendable {
    
    typealias T
    typealias D : Data
    
    init(_ storage : D)
    
    /**
    *  send a value
    *  
    *  - parameter value: sending value
    */
    func send(value : T)
    
}
