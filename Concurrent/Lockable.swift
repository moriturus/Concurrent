//
//  Lockable.swift
//  Concurrent
//
//  Created by moriturus on 8/12/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

/**
lock method protocol
*/
protocol Lockable {
    
    /**
    lock a thread
    */
    func lock()
    
}