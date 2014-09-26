//
//  Pushable.swift
//  Concurrent
//
//  Created by moriturus on 8/12/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

/**
push() method protocol
*/
protocol Pushable {
    
    typealias T
    
    /**
    push a object to data type
    
    :param: value pushing object
    */
    func push(value : T)
    
}
