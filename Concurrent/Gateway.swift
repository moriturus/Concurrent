//
//  Gateway.swift
//  channel
//
//  Created by Henrique Sasaki Yuya on 8/12/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

import Foundation

private class Gateway<T> {
    
    var storage : SafeQueue<T>
    
    init(_ storage : SafeQueue<T>) {
        
        self.storage = storage
        
    }
    
}

public class Sender<T> : Gateway<T> {
    
    override init(_ storage: SafeQueue<T>) {
        
        super.init(storage)
        
    }
    
}

public class Receiver<T> : Gateway<T> {
    
    override public init(_ storage: SafeQueue<T>) {
        
        super.init(storage)
        
    }
    
}

extension Sender : Sendable {
    
    public func send(value : T) {
        
        storage.push(value)
        
    }
    
}

extension Receiver : Receivable {
    
    public func receive() -> T {
        
        return storage.pop()
        
    }
    
}

infix operator <- {}

public func <-<T>(sender : Sender<T>, value : T) {
    
    sender.send(value)
    
}

prefix operator <- {}
public prefix func <-<T>(receiver : Receiver<T>) -> T {
    
    return receiver.receive()
    
}


