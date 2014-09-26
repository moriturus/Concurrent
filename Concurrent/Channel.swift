//
//  Channel.swift
//  Concurrent
//
//  Created by moriturus on 8/12/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

/**
Channel class
*/
public class Channel<T> {
    
    /// sender object
    public let sender : Sender<T>
    
    /// receiver object
    public let receiver : Receiver<T>
    
    /**
    initialize with sender and receiver object
    
    :param: sender   sender object
    :param: receiver receiver object
    
    :returns: channel instance
    */
    public init(_ sender : Sender<T>, _ receiver : Receiver<T>) {
        
        self.sender = sender
        self.receiver = receiver
        
    }

}

/**
extend Channel class to convenience initializer
*/
extension Channel {
    
    /**
    convenience initializer
    
    :returns: channel instance that has default gateways
    */
    convenience public init() {
        
        let (s, r) = Channel<T>.gateways()
        self.init(s,r)
        
    }
    
}

/**
extend Channel class to gateways class method
*/
extension Channel {
    
    /**
    create and return default gateways
    
    :returns: tupple that has sender and receiver
    */
    public class func gateways() -> (Sender<T>,Receiver<T>) {
        
        let storage = SafeQueue<T>()
        return (Sender(storage), Receiver(storage))
        
    }
    
}

/**
extend Channel class to Sendable protocol
*/
extension Channel : Sendable {

    /**
    send a value
    
    :param: value sending value
    */
    public func send(value : T) {
        
        sender.send(value)
        
    }
    
}

/**
extend Channel class to Receivable protocol
*/
extension Channel : Receivable {
    
    /**
    receive a value
    
    :returns: receiving value 
    */
    public func receive() -> T {
        
        return receiver.receive()
        
    }
    
}