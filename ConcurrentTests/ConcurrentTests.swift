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
            
            Dispatch.asyncOnMain {
                
                ch.send(NSThread.isMainThread())
                
            }
            
            return
            
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
    
    
    func testDispatchChain() {
        
        let ch = Channel<Bool>()
        
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(2*NSEC_PER_SEC))
        
        Dispatch.async {
            
            ch.send(true)
            
        } .after(time) {
                
            ch.send(false)
                
        }
        
        let result1 = ch.receive()
        let result2 = ch.receive()
        
        XCTAssertTrue(result1, "result1 is not true")
        XCTAssertFalse(result2, "resutl2 is true")
        
    }
    
    func testSampleCode() {
        
        let ch = Channel<UInt>()
        
        Dispatch.async {
            
            Dispatch.apply(1000) {
                
                i in
                
                ch.send(i)
                
            }
            
            return
            
        }
        
        for i in 0..<1000 {
            
            let val = ch.receive()
            XCTAssertTrue(UInt(i) == val, "val is not equal i")
            
        }
        
    }
    
}
