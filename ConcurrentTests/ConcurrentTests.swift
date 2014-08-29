//
//  ConcurrentTests.swift
//  ConcurrentTests
//
//  Created by Henrique Sasaki Yuya on 8/14/14.
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
        
        async {
            
            ch.send(true)
            
        }
        
        let result = ch.receive()
        
        XCTAssertTrue(result, "result is not true")
        
    }
    
    func testSync() {
        
        let ch = Channel<Bool>()
        
        sync {
            
            ch.send(true)
            
        }
        
        let result = ch.receive()
        
        XCTAssertTrue(result, "result is not true")
        
    }
    
    func testAsyncOnMain() {
        
        let ch = Channel<Bool>()
        
        async {
            
            asyncOnMain {
                
                ch.send(NSThread.isMainThread())
                
            }
            
        }
        
        async {
            
            let result = ch.receive()
            
            XCTAssertTrue(result, "result is not true")
            
        }
        
    }
    
    func testApply() {
        
        let ch = Channel<Bool>()
        
        apply(1000) {
            
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
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(3*NSEC_PER_SEC))
        
        after(time) {
            
            ch.send(true)
            
        }
        
        let result = ch.receive()
        
        XCTAssertTrue(result, "result is not true")
        
    }
    
}
