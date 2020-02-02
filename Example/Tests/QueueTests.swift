//
//  QueueTests.swift
//  DataStructure_Tests
//
//  Created by ezou on 2020/2/1.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import DataStructure

class QueueTests: XCTestCase {

    var sut: Queue<Int>!
    
    override func setUp() {
        super.setUp()
        sut = Queue<Int>(capacity: 3)
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func test_count() {
        XCTAssert(sut.count == 0)
        sut.enqueue(1)
        XCTAssert(sut.count == 1)
        sut.dequeue()
        XCTAssert(sut.count == 0)
    }
    
    func test_peek() {
        XCTAssert(sut.peek() == nil)
        sut.enqueue(1)
        XCTAssert(sut.peek() == 1)
    }
    
    func test_enqueue() {
        XCTAssert(sut.count == 0)
        sut.enqueue(1)
        XCTAssert(sut.count == 1)
    }
    
    func test_dequeue() {
        XCTAssert(sut.dequeue() == nil)
        sut.enqueue(1)
        XCTAssert(sut.dequeue() == 1)
    }
    
    func test_isEmpty() {
        sut.enqueue(1)
        XCTAssert(sut.isEmpty == false)
        sut.dequeue()
        XCTAssert(sut.isEmpty == true)
    }

    func test_resize() {
        sut.enqueue(1)
        sut.enqueue(2)
        sut.enqueue(3)
        sut.dequeue()
        sut.enqueue(4)
        sut.resize(capacity: 4)
        XCTAssert(sut.peek() == 2)
        XCTAssert(sut.capacity == 4)
        sut.enqueue(5)
        sut.enqueue(6)
        XCTAssert(sut.peek() == 2)
        for _ in 0...3 {
            sut.dequeue()
        }
        sut.resize(capacity: 1)
        XCTAssert(sut.peek() == 6)
    }
    
    func test_clear_releaseMemory() {
        sut.enqueue(1)
        sut.enqueue(2)
        XCTAssert(sut.count == 2)
        
        sut.clear()
        
        XCTAssert(sut.count == 0)
        XCTAssert(sut.peek() == nil)
    }
    
    func test_clear_notReleaseMemory() {
        sut.enqueue(1)
        sut.enqueue(2)
        
        XCTAssert(sut.count == 2)
        
        sut.clear(false)
        
        XCTAssert(sut.count == 0)
        XCTAssert(sut.peek() == nil)
    }
    
    func test_customStringComvertible() {
        sut.enqueue(1)
        sut.enqueue(2)
        sut.enqueue(3)
        XCTAssert(sut.description == [1,2,3].description)
        sut.dequeue()
        XCTAssert(sut.description == [2,3].description)
        sut.enqueue(4)
        let string = sut.description
        XCTAssert(string == [2,3,4].description)
        sut.enqueue(5)
        XCTAssert(sut.description == [2,3,4,5].description)
    }
    
    func test_expressibleByArrayLiteral() {
        sut = [1, 2, 3]
        XCTAssert(sut.peek() == 1)
        XCTAssert(sut.count == 3)
        XCTAssert(sut.description == [1, 2, 3].description)
        sut.dequeue()
        XCTAssert(sut.description == [2, 3].description)
        XCTAssert(sut[0] == 2)
    }
}
