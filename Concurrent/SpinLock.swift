//
//  SpinLock.swift
//  Concurrent
//
//  Created by Henrique Sasaki Yuya on 9/26/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

import Darwin

/**
spin lock wrapper class
*/
public class SpinLock {
    
    /// spin locking condition
    private var spinLock = OS_SPINLOCK_INIT
    
    public init() {}
    
}

/**
extend SpinLock class to Lockable protocol
*/
extension SpinLock : Lockable {
    
    /**
    lock a thread
    */
    public func lock() {
        
        withUnsafeMutablePointer(&spinLock, OSSpinLockLock)
        
    }
    
}

/**
extend SpinLock class to Unlockable protocol
*/
extension SpinLock : Unlockable {
    
    /**
    unlock a thread
    */
    public func unlock() {
        
        withUnsafeMutablePointer(&spinLock, OSSpinLockUnlock)
        
    }
    
}