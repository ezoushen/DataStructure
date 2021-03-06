import XCTest
import DataStructure

class StackTests: XCTestCase {
    
    var sut: Stack<Int>!
    
    override func setUp() {
        super.setUp()
        sut = Stack<Int>(capacity: 3)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_capacity() {
        XCTAssert(sut.capacity == 3)
    }
    
    func test_pop_throw() {
        XCTAssertThrowsError(try sut.pop())
    }
    
    func test_push_pop() {
        sut.push(1)
        XCTAssert((try? sut.pop()) == 1)
    }
    
    func test_peek() {
        sut.push(1)
        sut.push(2)
        XCTAssert(sut.peek() == 2)
    }
    
    func test_count() {
        sut.push(1)
        XCTAssert(sut.count == 1)
        sut.push(2)
        XCTAssert(sut.count == 2)
    }
    
    func test_isEmpty() {
        XCTAssert(sut.isEmpty == true)
        sut.push(1)
        XCTAssert(sut.isEmpty == false)
    }
    
    func test_isFull() {
        XCTAssert(sut.isFull == false)
        sut.push(1)
        sut.push(2)
        sut.push(3)
        XCTAssert(sut.isFull == true)
    }
    
    func test_resize() {
        XCTAssert(sut.capacity == 3)
        sut.resize(capacity: 6)
        XCTAssert(sut.capacity == 6)
    }
    
    func test_push_autoResize() {
        XCTAssert(sut.capacity == 3)
        sut.push(1)
        sut.push(2)
        sut.push(3)
        XCTAssert(sut.capacity == 3)
        sut.push(4)
        XCTAssert(sut.capacity == 6)
        XCTAssert(sut.count == 4)
        XCTAssert(sut.peek() == 4)
        XCTAssert((try? sut.pop()) == 4)
        XCTAssert(sut.peek() == 3)
    }
}
