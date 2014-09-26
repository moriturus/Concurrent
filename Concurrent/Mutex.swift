//
//  Mutex.swift
//  Concurrent
//
//  Created by moriturus on 8/12/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

import Darwin

/**
posix thread mutex wrapper class
*/
public class Mutex {
    
    /// mutex object pointer
    private let mutex: UnsafeMutablePointer<pthread_mutex_t>
    
    /// condition object pointer
    private let condition: UnsafeMutablePointer<pthread_cond_t>
    
    /// attribute object pointer
    private let attribute: UnsafeMutablePointer<pthread_mutexattr_t>
    
    /**
    initializer
    
    :returns: mutex class instance
    */
    public init() {
        
        mutex = UnsafeMutablePointer.alloc(sizeof(pthread_mutex_t))
        condition = UnsafeMutablePointer.alloc(sizeof(pthread_cond_t))
        attribute = UnsafeMutablePointer.alloc(sizeof(pthread_mutexattr_t))
        
        pthread_mutexattr_init(attribute)
        pthread_mutexattr_settype(attribute, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(mutex, attribute)
        pthread_cond_init(condition, nil)
        
    }
    
    /**
    deinitializer
    */
    deinit {
        
        pthread_cond_destroy(condition);
        pthread_mutexattr_destroy(attribute)
        pthread_mutex_destroy(mutex)
        
    }
    
}

/**
extend Mutex class to Lockable protocol
*/
extension Mutex : Lockable {
    
    /**
    lock a thread
    */
    public func lock() {
        
        pthread_mutex_lock(mutex)
        
    }
    
}

/**
extend Mutex class to Lockable protocol
*/
extension Mutex : Unlockable {
    
    /**
    unlock a thread
    */
    public func unlock() {
        
        pthread_mutex_unlock(mutex)
        
    }
    
}

/**
extend Mutex class to Waitable protocol
*/
extension Mutex : Waitable {
    
    /**
    wait a thread until signal()
    
    :returns: whether or not succeed in waiting a thread
    */
    public func wait() -> Bool {
        
        return pthread_cond_wait(condition, mutex) == 0
        
    }
    
}

/**
extend Mutex class to SignalSendable protocol
*/
extension Mutex : SignalSendable {
    
    /**
    send a signal to the waiting thread
    
    :returns: whether or not succeed in sending a signal to a thread
    */
    public func signal() -> Bool {
        
        return pthread_cond_signal(condition) == 0
        
    }
    
}

