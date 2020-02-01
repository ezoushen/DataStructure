//
//  Queue.swift
//  DataStructure
//
//  Created by ezou on 2020/2/1.
//

import Foundation

public struct Queue<T> {
    private var _contents: [T]
    private var _head: Int = 0
    private var _tail: Int = -1
    
    private(set) public var count: Int = 0
    private(set) public var capacity: Int {
        didSet {
            _contents.reserveCapacity(capacity)
        }
    }
    
    private var _isContinuous: Bool {
        return _head <= _tail
    }
    
    public var isEmpty: Bool {
        count == 0
    }
    
    public var isFull: Bool {
        capacity == count
    }
    
    public init(capacity: Int) {
        self.capacity = capacity
        
        _contents = [T]()
        _contents.reserveCapacity(capacity)
    }
    
    public mutating func enqueue(_ value: T) {
        if isFull {
            resize(capacity: capacity * 2)
        }
        _tail = (_tail + 1) % capacity
        (_tail < _contents.count)
            ? _contents[_tail] = value
            : _contents.append(value)
        count += 1
    }
    
    @discardableResult
    public mutating func dequeue() -> T? {
        guard count > 0 else { return nil }
        defer {
            _head = (_head + 1) % capacity
            count -= 1
        }
        return _contents[_head]
    }
    
    public func peek() -> T? {
        guard count > 0 else { return nil }
        return _contents[_head]
    }
    
    public mutating func clear(_ releaseMemory: Bool = true) {
        count = 0
        _head = 0
        _tail = -1
        
        guard releaseMemory else { return }
        _contents = [T]()
        capacity = 1
    }
    
    public mutating func resize(capacity newCapacity: Int) {
        precondition(capacity >= count, "required capacity must be greater than the number of contents")
        _contents.reserveCapacity(newCapacity)
        let size = MemoryLayout<T>.stride
        if _head > _tail {
            let isFirst = capacity - _head <= _tail + 1
            let temp = malloc(size * (isFirst ? capacity - _head : _tail + 1))
            if isFirst {
                memcpy(temp, &_contents + _head * size, size * (capacity - _head))
                memcpy(&_contents + (capacity - _head) * size, _contents, size * (_tail + 1))
                memcpy(&_contents, temp, size * (capacity - _head))
            } else {
                memcpy(temp, _contents, size * (_tail + 1))
                memcpy(&_contents, &_contents + _head * size, size * (capacity - _head))
                memcpy(&_contents + size * (capacity - _head), temp, size * (_tail + 1))
            }
        } else if _head == _tail {
            _contents[0] = _contents[_head]
        } else {
            memcpy(&_contents, &_contents + _head * size, count * size)
        }
        _head = 0
        _tail = count - 1
        capacity = newCapacity
    }
}

extension Queue: CustomStringConvertible {
    @inline(__always)
    private func createString(_ elements: ArraySlice<T>...) -> String {
        elements.flatMap{ $0 }.description
    }
    
    public var description: String {
        print(_head, _tail)
        return _isContinuous
            ? _contents[_head..._tail].description
            : createString(_contents[_head...], _contents[..._tail])
    }
}

extension Queue: ExpressibleByArrayLiteral {
    
    public typealias ArrayLiteralElement = T
    
    public init(arrayLiteral elements: T...) {
        _contents = elements
        count = 3
        capacity = elements.count
    }
}
