//
//  Channel.swift
//  Concurrent
//
//  Created by moriturus on 8/12/14.
//  Copyright (c) 2014-2015 moriturus. All rights reserved.
//

public protocol ChannelType : Sendable, Receivable {
    
    typealias S : Sendable
    typealias R : Receivable
    
    var sender : S { get }
    var receiver : R { get }
    
}

public class ProtoChannel<T, D : Data, S : Sendable, R : Receivable where D.T == T, S.T == T, S.D == D, R.T == T, R.D == D> : ChannelType {
    
    /// sender object
    public private(set) var sender : S
    
    /// receiver object
    public private(set) var receiver : R
    
    public init(_ sender : S, _ receiver : R) {
        
        self.sender = sender
        self.receiver = receiver
        
    }
    
    public convenience required init(_ storage: D) {
        
        let s = S(storage)
        let r = R(storage)
        self.init(s,r)
        
    }
    
    public func send(value: T) {
        
        sender.send(value)
        
    }
    
    public func receive() -> T {
        
        return receiver.receive()
        
    }
    
}

public class DataTypeReplaceableChannel<T, D: Data where D.T == T> : ProtoChannel<T, D, Sender<D>, Receiver<D>> {
    
    public typealias S = Sender<D>
    public typealias R = Receiver<D>
    
    public required init(_ storage: D) {
        
        let s = S(storage)
        let r = R(s)
        super.init(s, r)
        
    }
    
}

/**
Channel class
*/
public class Channel<T> : DataTypeReplaceableChannel<T, SafeQueue<T>> {
    
    public typealias D = SafeQueue<T>
    
    public required init(_ storage: D) {
        
        super.init(storage)
        
    }
    
    public convenience init() {
        
        let d = D()
        self.init(d)
        
    }

}

public class StackChannel<T> : DataTypeReplaceableChannel<T, SafeStack<T>> {
    
    public typealias D = SafeStack<T>
    
    public required init(_ storage: D) {
        
        super.init(storage)
        
    }
    
    public convenience init() {
        
        let d = D()
        self.init(d)
        
    }
    
    
}
