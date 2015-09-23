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
import Darwin

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
        
        let ch = Channel<Int>()
        
        Dispatch.async {
            
            for i in 0..<1000 {
                
                let val = ch.receive()
                XCTAssertTrue(i == val, "\(val) is not equal to \(i)")
                
            }
            
        }
        
        Dispatch.apply(1000) {
            
            i in
            
            ch.send(i)
            
            return
            
        }
        
    }
    
    func testStackChannel() {
        
        let sch = StackChannel<Int>()
        
        Dispatch.apply(10) {
            
            i in
            
            sch.send(i)
            
        }
        
        let nine = sch.receive()
        let eight = sch.receive()
        
        XCTAssertTrue(nine == 9, "not stacked: \(nine)")
        XCTAssertTrue(eight == 8, "not stacked: \(eight)")
        
    }
    
    func testPack() {
        
        let receiver = Pack<Int> {
            (sender) in
            
            sleep(10)
            
            sender.send(10)
            
        }.start()
        
        let ten = receiver.receive()
        
        XCTAssertTrue(ten == 10, "'ten' is not equal to 10")
        
    }
    
    func testStackChannelPack() {
        
        let receiver = StackChannelPack<Int> {
            
            (sender) in
            
            sender.send(10)
            sender.send(9)
            
            sleep(10)
            
        }.start()
        
        let nine = receiver.receive()
        let ten = receiver.receive()
        
        XCTAssertTrue(nine == 9)
        XCTAssertTrue(ten == 10)
        
    }
    
    func testNestedPack() {
        
        let p1 = Pack<Pack<Int>> {
            s1 in
            
            sleep(2)
            
            let p2 = Pack<Int> {
                s2 in
                
                sleep(3)
                s2.send(10)
                
            }
            
            s1.send(p2)
        }
        
        let r1 = p1.start()
        let r2 = r1.receive().start()
        
        let ten = r2.receive()
        
        XCTAssertTrue(ten == 10)
        
    }
    
}
