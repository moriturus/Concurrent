//
//  Receivable.swift
//  Concurrent
//
//  Created by moriturus on 8/12/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

public protocol Receivable {
    
    typealias T
    
    /**
    *  receive a value
    *
    *  :returns: receiving value
    */
    func receive() -> T
    
}
