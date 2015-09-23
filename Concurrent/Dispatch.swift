//
//  Dispatch.swift
//  Concurrent
//
//  Created by moriturus on 8/28/14.
//  Copyright (c) 2014-2015 moriturus. All rights reserved.
//

import Dispatch

/**
Grand Central Dispatch functions wrapper
*/
public struct Dispatch {
    
    /**
    spawn a asynchronous job in non-main queue
    
    - parameter f:        applying function
    - parameter priority: queue priority
    */
    public static func async(priority : Int = DISPATCH_QUEUE_PRIORITY_DEFAULT, _ f : Void -> Void) {
        
        dispatch_async(dispatch_get_global_queue(priority, 0), f)
        
    }
    
    /**
    spawn a synchronous job in non-main queue
    
    - parameter f:        applying function
    - parameter priority: queue priority
    */
    public static func sync(priority : Int = DISPATCH_QUEUE_PRIORITY_DEFAULT, _ f : Void -> Void) {
        
        dispatch_sync(dispatch_get_global_queue(priority, 0), f)
        
    }
    
    /**
    spawn a asynchronous job in the main queue
    
    - parameter f: applying function
    */
    public static func UI(f : Void -> Void) {
        
        dispatch_async(dispatch_get_main_queue(), f)
        
    }
    
    /**
    spawn a multi-queue iterational job in non-main queue
    
    - parameter iterations: iterational count
    - parameter f:          applying function
    - parameter priority:   queue priority
    */
    public static func apply(iterations : Int, _ priority : Int, _ f : (Int) -> Void) {
        
        dispatch_apply(iterations, dispatch_get_global_queue(priority, 0), f)
        
    }
    
    public static func apply(iterations : Int, _ f : (Int) -> Void) {
        
        apply(iterations, DISPATCH_QUEUE_PRIORITY_DEFAULT, f)
        
    }
    
    /**
    spawn a asynchronous job in non-main queue after the specified time
    
    - parameter when:     time to be fired
    - parameter f:        applying function
    - parameter priority: queue priority
    */
    public static func after(when : dispatch_time_t, _ priority : Int, _ f : Void -> Void) {
        
        dispatch_after(when, dispatch_get_global_queue(priority, 0), f)
        
    }
    
    public static func after(when : dispatch_time_t, _ f : Void -> Void) {
        
        after(when, DISPATCH_QUEUE_PRIORITY_DEFAULT, f)
        
    }
    
}
