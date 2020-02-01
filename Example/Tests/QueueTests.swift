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

    func test_capacity() {
        print(sut.capacity)
        XCTAssert(sut.capacity == 3)
    }
    
    func test_count() {
        XCTAssert(sut.count == 0)
        sut.enqueue(1)
        XCTAssert(sut.count == 1)
        XCTAssert(sut.dequeue() == 1)
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
    
    func test_isFull() {
        sut.enqueue(1)
        sut.enqueue(2)
        sut.enqueue(3)
        XCTAssert(sut.isFull == true)
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
        print(sut.capacity)

        XCTAssert(sut.capacity == 4)
        sut.enqueue(5)
        sut.enqueue(6)
        print(sut.capacity)

        XCTAssert(sut.capacity == 8)
        for _ in 0...3 {
            sut.dequeue()
        }
        sut.resize(capacity: 1)
        print(sut.capacity)

        XCTAssert(sut.capacity == 1)
    }
    
    func test_clear_releaseMemory() {
        sut.enqueue(1)
        sut.enqueue(2)
        
        XCTAssert(sut.count == 2)
        
        sut.clear()
        
        XCTAssert(sut.capacity == 1)
        XCTAssert(sut.count == 0)
        XCTAssert(sut.peek() == nil)
    }
    
    func test_clear_notReleaseMemory() {
        sut.enqueue(1)
        sut.enqueue(2)
        
        XCTAssert(sut.count == 2)
        
        sut.clear(false)
        
        XCTAssert(sut.capacity == 3)
        XCTAssert(sut.count == 0)
        XCTAssert(sut.peek() == nil)
    }
}
