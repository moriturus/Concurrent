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
private class Gateway<D : Data> {
    
    /// buffer storage
    var storage : D
    
    /**
    initialize with storage
    
    :param: storage buffer storage
    
    :returns: gateway instance
    */
    init(_ storage : D) {
        
        self.storage = storage
        
    }
    
}

/**
sender class
*/
public class Sender<D : Data> : Gateway<D> {
    
    /**
    initialize with storage
    
    :param: storage buffer storage
    
    :returns: sender instance
    */
    override public required init(_ storage: D) {
        
        super.init(storage)
        
    }
    
}

/**
receiver class
*/
public class Receiver<D : Data> : Gateway<D> {
    
    /**
    initialize with storage
    
    :param: storage buffer storage
    
    :returns: receiver instance
    */
    override public required init(_ storage: D) {
        
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
    convenience public init(_ receiver : Receiver<D>) {
        
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
    convenience public init(_ sender : Sender<D>) {
        
        self.init(sender.storage)
        
    }
    
}

/**
extend sender class to Sendable protocol
*/
extension Sender : Sendable {
    
    typealias T = D.T
    
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
    
    typealias T = D.T
    
    /**
    receive a value
    
    :returns: receiving value
    */
    public func receive() -> T {
        
        return storage.pop()
        
    }
    
}


