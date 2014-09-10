//
//  Sendable.swift
//  Concurrent
//
//  Created by moriturus on 8/12/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

protocol Sendable {
    
    typealias T
    func send(value : T)
    
}
