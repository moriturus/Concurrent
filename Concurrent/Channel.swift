//
//  Channel.swift
//  Concurrent
//
//  Created by moriturus on 8/12/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

public class Channel<T> {
    
    public let sender : Sender<T>
    public let receiver : Receiver<T>
    
    public init(_ sender : Sender<T>, _ receiver : Receiver<T>) {
        
        self.sender = sender
        self.receiver = receiver
        
    }

}

extension Channel {
    
    convenience public init() {
        
        let (s, r) = Channel<T>.gateways()
        self.init(s,r)
        
    }
    
}

extension Channel {
    
    public class func gateways() -> (Sender<T>,Receiver<T>) {
        
        let storage = SafeQueue<T>()
        return (Sender(storage), Receiver(storage))
        
    }
    
}

extension Channel : Sendable {
    
    public func send(value : T) {
        
        sender.send(value)
        
    }
    
}

extension Channel : Receivable {
    
    public func receive() -> T {
        
        return receiver.receive()
        
    }
    
}