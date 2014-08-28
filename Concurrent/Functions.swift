//
//  Functions.swift
//  channel
//
//  Created by Henrique Sasaki Yuya on 8/28/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

import Dispatch

public func async(f : Void -> Void, priority : Int = DISPATCH_QUEUE_PRIORITY_DEFAULT) {
    
    dispatch_async(dispatch_get_global_queue(priority, 0), f)
    
}

public func sync(f : Void -> Void, priority : Int = DISPATCH_QUEUE_PRIORITY_DEFAULT) {
    
    dispatch_sync(dispatch_get_global_queue(priority, 0), f)
    
}

public func asyncOnMain(f : Void -> Void) {
    
    dispatch_async(dispatch_get_main_queue(), f)
    
}

public func apply(iterations : UInt, f : (UInt) -> Void, priority : Int = DISPATCH_QUEUE_PRIORITY_DEFAULT) {
    
    dispatch_apply(iterations, dispatch_get_global_queue(priority, 0), f)
    
}

public func after(when : dispatch_time_t, f : Void -> Void, priority : Int = DISPATCH_QUEUE_PRIORITY_DEFAULT) {
    
    dispatch_after(when, dispatch_get_global_queue(priority, 0), f)
    
}
