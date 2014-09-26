//
//  Gateway.swift
//  Concurrent
//
//  Created by moriturus on 8/12/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

/**
gateway base class
*/
private class Gateway<T> {
    
    /// buffer storage
    var storage : SafeQueue<T>
    
    /**
    initialize with storage
    
    :param: storage buffer storage
    
    :returns: gateway instance
    */
    init(_ storage : SafeQueue<T>) {
        
        self.storage = storage
        
    }
    
}

/**
sender class
*/
public class Sender<T> : Gateway<T> {
    
    /**
    initialize with storage
    
    :param: storage buffer storage
    
    :returns: sender instance
    */
    override public init(_ storage: SafeQueue<T>) {
        
        super.init(storage)
        
    }
    
}

/**
receiver class
*/
public class Receiver<T> : Gateway<T> {
    
    /**
    initialize with storage
    
    :param: storage buffer storage
    
    :returns: receiver instance
    */
    override public init(_ storage: SafeQueue<T>) {
        
        super.init(storage)
        
    }
    
}

/**
extend Sender class to convenience initializer
*/
extension Sender {
    
    /**
    initialize with Receiver class
    
    :param: receiver receiver object which is shared its storage with the sender object
    
    :returns: sender instance
    */
    convenience public init(_ receiver : Receiver<T>) {
        
        self.init(receiver.storage)
        
    }
    
    /**
    initialize with default storage
    
    :returns: sender instance
    */
    convenience public init() {
        
        self.init(SafeQueue<T>())
        
    }
    
}

/**
extend Receiver class to convenience initializer
*/
extension Receiver {
    
    /**
    initialize with Sender class
    
    :param: sender sender object which is shared its storage with the receiver object
    
    :returns: receiver instance
    */
    convenience public init (_ sender : Sender<T>) {
        
        self.init(sender.storage)
        
    }
    
    /**
    initialize with default storage
    
    :returns: receiver instance
    */
    convenience public init() {
        
        self.init(SafeQueue<T>())
        
    }
    
}

/**
extend sender class to Sendable protocol
*/
extension Sender : Sendable {
    
    /**
    send a value
    
    :param: value sending value
    */
    public func send(value : T) {
        
        storage.push(value)
        
    }
    
}

/**
extend receiver class to Receivable protocol
*/
extension Receiver : Receivable {
    
    /**
    receive a value
    
    :returns: receiving value
    */
    public func receive() -> T {
        
        return storage.pop()
        
    }
    
}


