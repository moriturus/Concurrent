//
//  Semaphore.swift
//  Concurrent
//
//  Created by moriturus on 8/12/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

import Dispatch

public class Semaphore {
    
    private var semaphore : dispatch_semaphore_t
    
    init(_ count : Int) {
        
        semaphore = dispatch_semaphore_create(count)
        
    }
    
}

extension Semaphore {
    
    convenience init() {
        
        self.init(1)
        
    }
  
}

extension Semaphore : Lockable {
    
    public func lock() {
        
        wait()
        
    }
    
}

extension Semaphore : Unlockable {
    
    public func unlock() {
        
        signal()
        
    }
    
}

extension Semaphore : Waitable {
    
    public func wait() -> Bool {
        
        return wait(DISPATCH_TIME_FOREVER)
        
    }
    
    public func wait(timeout : dispatch_time_t!) -> Bool {
        
        return dispatch_semaphore_wait(semaphore, timeout) == 0
        
    }
    
}

extension Semaphore : SignalSendable {
    
    public func signal() -> Bool {
        
        return dispatch_semaphore_signal(semaphore) != 0
        
    }
    
}



