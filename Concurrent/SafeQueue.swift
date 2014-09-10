//
//  SafeQueue.swift
//  Concurrent
//
//  Created by moriturus on 8/12/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

public class SafeQueue<T> {
    
    private var storage : [T] = []
    private var mutex : Mutex
    
    public init() {
        
        mutex = Mutex()
        
    }
    
}

extension SafeQueue : Pushable {
    
    public func push(value: T) {
        
        mutex.lock()
        
        storage.append(value)
        
        mutex.unlock()
        
        mutex.signal()
        
    }
    
}

extension SafeQueue : Poppable {
    
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

extension SafeQueue {
    
    public var isEmpty : Bool {
        
        return storage.isEmpty
            
    }
    
}