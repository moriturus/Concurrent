//
//  Semaphore.swift
//  Concurrent
//
//  Created by moriturus on 8/12/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

import Dispatch

/**
Semaphore wrapper class
*/
public class Semaphore {
    
    /// GCD semaphore object
    private var semaphore : dispatch_semaphore_t
    
    /**
    initialize with semaphore's capacity
    
    :param: count capacity
    
    :returns: Semaphore instance
    */
    public init(_ count : Int) {
        
        semaphore = dispatch_semaphore_create(count)
        
    }
    
}

/**
extend Semaphore class to convenience initializer
*/
extension Semaphore {
    
    /**
    same as init(1)
    
    :returns: Semaphore instance
    */
    public convenience init() {
        
        self.init(1)
        
    }
  
}

/**
extend Semaphore class to Lockable protocol
*/
extension Semaphore : Lockable {
    
    /**
    lock a thread
    */
    public func lock() {
        
        wait()
        
    }
    
}

/**
extend Semaphore class to Unlockable protocol
*/
extension Semaphore : Unlockable {
    
    /**
    unlock a thread
    */
    public func unlock() {
        
        signal()
        
    }
    
}

/**
extend Semaphore class to Waitable protocol
*/
extension Semaphore : Waitable {
    
    /**
    wait a thread forever
    
    :returns: whether or not to
    */
    public func wait() -> Bool {
        
        return wait(DISPATCH_TIME_FOREVER)
        
    }
    
    /**
    wait a thread until definited time
    
    :param: timeout timeout value
    
    :returns: whether or not to succeed in waiting a thread
    */
    public func wait(timeout : dispatch_time_t!) -> Bool {
        
        return dispatch_semaphore_wait(semaphore, timeout) == 0
        
    }
    
}

/**
extend Semaphore class to SignalSendable protocol
*/
extension Semaphore : SignalSendable {
    
    /**
    send a signal to semaphore
    
    :returns: whether or not to succeed in awaking a thread
    */
    public func signal() -> Bool {
        
        return dispatch_semaphore_signal(semaphore) != 0
        
    }
    
}



