//
//  Channel.swift
//  channel
//
//  Created by Henrique Sasaki Yuya on 8/12/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

public class Channel<T> {
    
    private var sender : Sender<T>
    private var receiver : Receiver<T>
    
    public init(_ sender : Sender<T>, _ receiver : Receiver<T>) {
        
        self.sender = sender
        self.receiver = receiver
        
    }

}

extension Channel {
    
    convenience public init(_ capacity : Int = 16) {
        
        let (s, r) = Channel<T>.gateways(capacity)
        self.init(s,r)
        
    }
    
}

extension Channel {
    
    public class func gateways(_ capacity : Int = 16) -> (Sender<T>,Receiver<T>) {
        
        let storage = SafeQueue<T>(capacity)
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