//
//  SafeQueue.swift
//  Concurrent
//
//  Created by moriturus on 8/12/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

/**
thread safe queue class
*/
public class SafeQueue<T> {
    
    /// storage
    private var storage : [T] = []
    
    /// thread mutex
    private var mutex : Mutex
    
    /**
    default initializer
    
    :returns: SafeQueue instance
    */
    public init() {
        
        mutex = Mutex()
        
    }
    
}

/**
extend SafeQueue class to Pushable protocol
*/
extension SafeQueue : Pushable {
    
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
    
}

/**
extend SafeQueue class to Poppable protocol
*/
extension SafeQueue : Poppable {
    
    /**
    pop a value from the storage
    
    :returns: popped value
    */
    public func pop() -> T {
        
        mutex.lock()
        
        while isEmpty {
            
            mutex.wait()
            
        }
        
        let retval = storage[0]
        storage.removeAtIndex(0)
        
        mutex.unlock()
        
        return retval
        
    }
    
}

/**
extend SafeQueue class to isEmpty property
*/
extension SafeQueue {
    
    public var isEmpty : Bool {
        
        return storage.isEmpty
            
    }
    
}