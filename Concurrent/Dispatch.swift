//
//  Dispatch.swift
//  Concurrent
//
//  Created by moriturus on 8/28/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

import Dispatch

public struct Dispatch {
    
    public static func async(f : Void -> Void, _ priority : Int = DISPATCH_QUEUE_PRIORITY_DEFAULT) -> Dispatch.Type {
        
        dispatch_async(dispatch_get_global_queue(priority, 0), f)
        
        return self
        
    }
    
    public static func sync(f : Void -> Void, _ priority : Int = DISPATCH_QUEUE_PRIORITY_DEFAULT) -> Dispatch.Type {
        
        dispatch_sync(dispatch_get_global_queue(priority, 0), f)
        
        return self
        
    }
    
    public static func asyncOnMain(f : Void -> Void) -> Dispatch.Type {
        
        dispatch_async(dispatch_get_main_queue(), f)
        
        return self
        
    }
    
    public static func apply(iterations : UInt, _ f : (UInt) -> Void, _ priority : Int = DISPATCH_QUEUE_PRIORITY_DEFAULT) -> Dispatch.Type {
        
        dispatch_apply(iterations, dispatch_get_global_queue(priority, 0), f)
        
        return self
        
    }
    
    public static func after(when : dispatch_time_t, _ f : Void -> Void, _ priority : Int = DISPATCH_QUEUE_PRIORITY_DEFAULT) -> Dispatch.Type {
        
        dispatch_after(when, dispatch_get_global_queue(priority, 0), f)
        
        return self
        
    }
    
}
