//
//  ConcurrentTests.swift
//  ConcurrentTests
//
//  Created by moriturus on 8/14/14.
//  Copyright (c) 2014 moriturus. All rights reserved.
//

import Cocoa
import XCTest
import Concurrent

class ConcurrentTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAsync() {
        
        let ch = Channel<Bool>()

        Dispatch.async {
            
            ch.send(true)
            
        }
        
        let result = ch.receive()
        
        XCTAssertTrue(result, "result is not true")
        
    }
    
    func testSync() {
        
        let ch = Channel<Bool>()
        
        Dispatch.sync {
            
            ch.send(true)
            
        }
        
        let result = ch.receive()
        
        XCTAssertTrue(result, "result is not true")
        
    }
    
    func testAsyncOnMain() {
        
        let ch = Channel<Bool>()
        
        Dispatch.async {
            
            Dispatch.UI {
                
                ch.send(NSThread.isMainThread())
                
            }
            
        }
        
        Dispatch.async {
            
            let result = ch.receive()
            
            XCTAssertTrue(result, "result is not true")
            
        }
        
    }
    
    func testApply() {
        
        let ch = Channel<Bool>()
        
        Dispatch.apply(1000) {
            
            i in
            
            if i > 998 {
                
                ch.send(true)
                
            }
            
        }
        
        let result = ch.receive()
        
        XCTAssertTrue(result, "result is not true")
        
    }
    
    func testAfter() {
        
        let ch = Channel<Bool>()
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(2*NSEC_PER_SEC))
        
        Dispatch.after(time) {
            
            ch.send(true)
            
        }
        
        let result = ch.receive()
        
        XCTAssertTrue(result, "result is not true")
        
    }
    
    func senderTester<
        SenderType : Sendable
        where SenderType.T : BooleanLiteralConvertible
        >(sender : SenderType) -> Void {
        
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(2*NSEC_PER_SEC))
        
        Dispatch.after(time) {
            
            sender.send(true)
            
            return
            
        }
        
    }
    
    func testSenderArgument() {
        
        let ch = Channel<Bool>()
        
        senderTester(ch.sender)
        
        let result = ch.receive()
        
        XCTAssertTrue(result, "result1 is not true")
        
    }
    
    func receiverTester<
        ReceiverType : Receivable
        where ReceiverType.T : BooleanType
        >(receiver : ReceiverType) {
        
        let result = receiver.receive()
        XCTAssertTrue(result, "result1 is not true")
        
    }
    
    func testReceiverArgument() {
        
        let ch = Channel<Bool>()
        
        Dispatch.async {
            
            ch.send(true)
            
        }
        
        receiverTester(ch.receiver)
        
        
    }
    
    func testNestedChannel() {
        
        let parent = Channel<Channel<Bool>>()
        
        let time1 = dispatch_time(DISPATCH_TIME_NOW, Int64(2*NSEC_PER_SEC))
    
        Dispatch.after(time1) {
            
            let child = Channel<Bool>()
            parent.send(child)
            
            let time2 = dispatch_time(DISPATCH_TIME_NOW, Int64(2*NSEC_PER_SEC))
            
            Dispatch.after(time2) {
                
                child.send(true)
                
            }
            
        }
        
        let result = parent.receive().receive()
        XCTAssertTrue(result, "result is not true")
        
    }
    
    func testSampleCode() {
        
        let ch = Channel<UInt>()
        
        Dispatch.async {
            
            for i in 0..<1000 {
                
                let val = ch.receive()
                XCTAssertTrue(UInt(i) == val, "\(val) is not equal to \(i)")
                
            }
            
        }
        
        Dispatch.apply(1000) {
            
            i in
            
            ch.send(i)
            
        }
        
    }
    
    func testStackChannel() {
        
        let sch = StackChannel<UInt>()
        
        Dispatch.apply(10) {
            
            i in
            
            sch.send(i)
            
        }
        
        let nine = sch.receive()
        let eight = sch.receive()
        
        XCTAssertTrue(nine == 9, "not stacked: \(nine)")
        XCTAssertTrue(eight == 8, "not stacked: \(eight)")
        
    }
    
}
