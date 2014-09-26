//
//  Poppable.swift
//  Concurrent
//
//  Created by moriturus on 8/12/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

/**
pop() method protocol
*/
protocol Poppable {
    
    typealias T
    
    /**
    pop a object from data type
    
    :returns: popped object
    */
    func pop() -> T
    
}
