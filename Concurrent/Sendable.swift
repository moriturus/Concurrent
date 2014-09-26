//
//  Sendable.swift
//  Concurrent
//
//  Created by moriturus on 8/12/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

public protocol Sendable {
    
    typealias T
    
    /**
    *  send a value
    *  
    *  :param: value sending value
    */
    func send(value : T)
    
}
