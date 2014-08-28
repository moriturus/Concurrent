//
//  Value.swift
//  channel
//
//  Created by Henrique Sasaki Yuya on 8/12/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

public class Value<T> {
    
    private var value : T
    
    init(_ val : T) {
        
        value = val
        
    }
    
    public func get() -> T {
        
        return value
        
    }
    
    public func set(val : T) {
        
        value = val
        
    }
    
}
