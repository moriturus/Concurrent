//
//  SignalSendable.swift
//  Concurrent
//
//  Created by moriturus on 8/12/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

public protocol SignalSendable {
    
    /**
    send a signal to thread locking/blocking system
    
    :returns: whether or not to succeed in awaking a thread
    */
    func signal() -> Bool
    
}
