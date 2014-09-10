//
//  Mutex.swift
//  Concurrent
//
//  Created by moriturus on 8/12/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

import Darwin

public class Mutex {
    
    private let mutex: UnsafeMutablePointer<pthread_mutex_t>
    private let condition: UnsafeMutablePointer<pthread_cond_t>
    private let attribute: UnsafeMutablePointer<pthread_mutexattr_t>
    
    init() {
        
        mutex = UnsafeMutablePointer.alloc(sizeof(pthread_mutex_t))
        condition = UnsafeMutablePointer.alloc(sizeof(pthread_cond_t))
        attribute = UnsafeMutablePointer.alloc(sizeof(pthread_mutexattr_t))
        
        pthread_mutexattr_init(attribute)
        pthread_mutexattr_settype(attribute, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(mutex, attribute)
        pthread_cond_init(condition, nil)
        
    }
    
    deinit {
        
        pthread_cond_destroy(condition);
        pthread_mutexattr_destroy(attribute)
        pthread_mutex_destroy(mutex)
        
    }
    
}

extension Mutex : Lockable {
    
    public func lock() {
        
        pthread_mutex_lock(mutex)
        
    }
    
}

extension Mutex : Unlockable {
    
    public func unlock() {
        
        pthread_mutex_unlock(mutex)
        
    }
    
}

extension Mutex : Waitable {
    
    public func wait() -> Bool {
        
        return pthread_cond_wait(condition, mutex) == 0
        
    }
    
}

extension Mutex : SignalSendable {
    
    public func signal() -> Bool {
        
        return pthread_cond_signal(condition) == 0
        
    }
    
}

