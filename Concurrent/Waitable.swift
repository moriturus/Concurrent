//
//  Waitable.swift
//  Concurrent
//
//  Created by moriturus on 8/12/14.
//  Copyright (c) 2014-2015 moriturus. All rights reserved.
//

protocol Waitable {
    
    /**
    wait a thread
    
    - returns: whether or not to succeed in waiting a thread
    */
    func wait() -> Bool
    
}
