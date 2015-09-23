//
//  Promise.swift
//  Concurrent
//
//  Created by Henrique Sasaki Yuya on 9/22/15.
//  Copyright © 2015 moriturus. All rights reserved.
//

public protocol PackType {
    
    typealias R: Receivable
    
    func start() -> R
    
}

public class ChannelTypeReplaceablePack<CT: ChannelType, T where CT.T == T>: PackType {
    
    public typealias R = CT.R
    public typealias S = CT.S
    
    public typealias Task = (S) -> Void
    
    private let task: Task
    private let channel: CT
    
    public init(task: Task, channel: CT) {
        
        self.task = task
        self.channel = channel
        
    }
    
    public func start() -> R {
        
        Dispatch.async {
            
            self.task(self.channel.sender)
            
        }
        
        return self.channel.receiver
        
    }
    
}


public class Pack<T>: ChannelTypeReplaceablePack<Channel<T>, T> {
    
    public init(task: Task) {
        
        super.init(task: task, channel: Channel())
        
    }

}

public class StackChannelPack<T>: ChannelTypeReplaceablePack<StackChannel<T>, T> {
    
    public init(task: Task) {
        
        super.init(task: task, channel: StackChannel())
        
    }
    
}
