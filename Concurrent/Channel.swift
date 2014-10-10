//
//  Channel.swift
//  Concurrent
//
//  Created by moriturus on 8/12/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

public protocol ChannelType : Sendable,Receivable {
    
    typealias S : Sendable
    typealias R : Receivable
    
    var sender : S { get }
    var receiver : R { get }
    
}

public class ProtoChannel<T, D : Data, S : Sendable, R : Receivable where D.T == T, S.T == T, R.T == T> : ChannelType {
    
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
public class Channel<T> : ProtoChannel<T,D,S,R> {
    
    public typealias D = SafeQueue<T>
    public typealias S = Sender<D>
    public typealias R = Receiver<D>
    
    public init() {

        let d = D()
        let s = S(d)
        let r = R(s)
        super.init(s,r)
        
    }

}

public class StackChannel<T> : ProtoChannel<T,D,S,R> {
    
    public typealias D = SafeStack<T>
    public typealias S = Sender<D>
    public typealias R = Receiver<D>
    
    public init() {
        
        let d = D()
        let s = S(d)
        let r = R(s)
        super.init(s,r)
        
    }
    
}
