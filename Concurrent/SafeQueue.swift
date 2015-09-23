//
//  SafeQueue.swift
//  Concurrent
//
//  Created by moriturus on 8/12/14.
//  Copyright (c) 2014-2015 moriturus. All rights reserved.
//

/**
thread safe queue class
*/
public class SafeQueue<Type> {
    
    public typealias T = Type
    
    /// storage
    private var storage : [T] = []
    
    /// thread mutex
    private var mutex : Mutex
    
    /**
    default initializer
    
    - returns: SafeQueue instance
    */
    public required init() {
        
        mutex = Mutex()
        
    }
    
}

/**
extend SafeQueue class to Pushable protocol
*/
extension SafeQueue : Data {
    
    /**
    push a value to the storage
    
    - parameter value: pushing value
    */
    public func push(value: T) {
        
        mutex.lock()
        
        storage.append(value)
        
        mutex.unlock()
        
        mutex.signal()
        
    }
    
    /**
    pop a value from the storage
    
    - returns: popped value
    */
    public func pop() -> T {
        
        mutex.lock()
        
        while isEmpty {
            
            mutex.wait()
            
        }
        
        let retval = storage.removeAtIndex(0)
        
        mutex.unlock()
        
        return retval
        
    }
    
    public var isEmpty : Bool {
        
        return storage.isEmpty
        
    }
    
}
