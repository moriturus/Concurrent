//
//  Data.swift
//  Concurrent
//
//  Created by moriturus on 10/4/14.
//  Copyright (c) 2014-2015 moriturus. All rights reserved.
//

public protocol Data : Pushable, Poppable, EmptyCheckable {
    
    typealias T
    
    init()
    
}


