//
//  Dispatch.swift
//  Concurrent
//
//  Created by moriturus on 8/28/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

import Dispatch

/**
Grand Central Dispatch functions wrapper
*/
public struct Dispatch {
    
    /**
    spawn a asynchronous job in non-main queue
    
    :param: f        applying function
    :param: priority queue priority
    */
    public static func async(f : Void -> Void, _ priority : Int = DISPATCH_QUEUE_PRIORITY_DEFAULT) {
        
        dispatch_async(dispatch_get_global_queue(priority, 0), f)
        
    }
    
    /**
    spawn a synchronous job in non-main queue
    
    :param: f        applying function
    :param: priority queue priority
    */
    public static func sync(f : Void -> Void, _ priority : Int = DISPATCH_QUEUE_PRIORITY_DEFAULT) {
        
        dispatch_sync(dispatch_get_global_queue(priority, 0), f)
        
    }
    
    /**
    spawn a asynchronous job in the main queue
    
    :param: f applying function
    */
    public static func UI(f : Void -> Void) {
        
        dispatch_async(dispatch_get_main_queue(), f)
        
    }
    
    /**
    spawn a multi-queue iterational job in non-main queue
    
    :param: iterations iterational count
    :param: f          applying function
    :param: priority   queue priority
    */
    public static func apply(iterations : UInt, _ f : (UInt) -> Void, _ priority : Int = DISPATCH_QUEUE_PRIORITY_DEFAULT) {
        
        dispatch_apply(iterations, dispatch_get_global_queue(priority, 0), f)
        
    }
    
    /**
    spawn a asynchronous job in non-main queue after the specified time
    
    :param: when     time to be fired
    :param: f        applying function
    :param: priority queue priority
    */
    public static func after(when : dispatch_time_t, _ f : Void -> Void, _ priority : Int = DISPATCH_QUEUE_PRIORITY_DEFAULT) {
        
        dispatch_after(when, dispatch_get_global_queue(priority, 0), f)
        
    }
    
}
