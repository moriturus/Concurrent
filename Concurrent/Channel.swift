//
//  Channel.swift
//  Concurrent
//
//  Created by moriturus on 8/12/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

public protocol ChannelType : Sendable,Receivable {
}

public class ProtoChannel<T, Q : Queue, S : Sendable, R : Receivable where Q.T == T, S.T == T, R.T == T> : ChannelType {
    
    /// sender object
    public private(set) var sender : S
    
    /// receiver object
    public private(set) var receiver : R
    
    public init(_ sender : S, _ receiver : R) {
        
        self.sender = sender
        self.receiver = receiver
        
    }
    
    public func send(value: T) {
        
        sender.send(value)
        
    }
    
    public func receive() -> T {
        
        return receiver.receive()
        
    }
    
}

/**
Channel class
*/
public class Channel<T> : ProtoChannel<T,Q,S,R> {
    
    public typealias Q = SafeQueue<T>
    public typealias S = Sender<Q>
    public typealias R = Receiver<Q>
    
    public init() {

        let q = Q()
        let s = S(q)
        let r = R(s)
        super.init(s,r)
        
    }

}

public class StackChannel<T> : ProtoChannel<T,Q,S,R> {
    
    public typealias Q = SafeStack<T>
    public typealias S = Sender<Q>
    public typealias R = Receiver<Q>
    
    public init() {
        
        let q = Q()
        let s = S(q)
        let r = R(s)
        super.init(s,r)
        
    }
    
}
