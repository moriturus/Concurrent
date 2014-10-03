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
private class Gateway<Q : Queue> {
    
    typealias T = Q.T
    
    /// buffer storage
    var storage : Q
    
    /**
    initialize with storage
    
    :param: storage buffer storage
    
    :returns: gateway instance
    */
    init(_ storage : Q) {
        
        self.storage = storage
        
    }
    
}

/**
sender class
*/
public class Sender<Q : Queue> : Gateway<Q> {
    
    /**
    initialize with storage
    
    :param: storage buffer storage
    
    :returns: sender instance
    */
    override public init(_ storage: Q) {
        
        super.init(storage)
        
    }
    
}

/**
receiver class
*/
public class Receiver<Q : Queue> : Gateway<Q> {
    
    /**
    initialize with storage
    
    :param: storage buffer storage
    
    :returns: receiver instance
    */
    override public init(_ storage: Q) {
        
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
    convenience public init(_ receiver : Receiver<Q>) {
        
        self.init(receiver.storage)
        
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
    convenience public init (_ sender : Sender<Q>) {
        
        self.init(sender.storage)
        
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


