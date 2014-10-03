//
//  SafeStack.swift
//  Concurrent
//
//  Created by Henrique Sasaki Yuya on 10/3/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

public class SafeStack<T> {
    
    /// storage
    private var storage : [T] = []
    
    /// thread mutex
    private var mutex : Mutex
    
    /**
    default initializer
    
    :returns: SafeStack instance
    */
    public init() {
        
        mutex = Mutex()
        
    }
    
}

/**
extend SafeStack class to Pushable protocol
*/
extension SafeStack : Data {
    
    /**
    push a value to the storage
    
    :param: value pushing value
    */
    public func push(value: T) {
        
        mutex.lock()
        
        storage.append(value)
        
        mutex.unlock()
        
        mutex.signal()
        
    }
    
    /**
    pop a value from the storage
    
    :returns: popped value
    */
    public func pop() -> T {
        
        mutex.lock()
        
        while isEmpty {
            
            mutex.wait()
            
        }
        
        let retval = storage.removeLast()
        
        mutex.unlock()
        
        return retval
        
    }
    
    public var isEmpty : Bool {
        
        return storage.isEmpty
        
    }
    
}


