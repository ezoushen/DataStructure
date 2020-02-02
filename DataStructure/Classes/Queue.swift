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
    private var _tail: Int = 0

    private var _isContinuous: Bool {
        _head == _tail && _head == 0
    }

    private var _count: Int {
        _contents.count
    }

    public var count: Int {
        _contents.count - _head + _tail
    }

    public var capacity: Int {
        _contents.capacity
    }

    public var isEmpty: Bool {
        count == 0
    }

    public var isFull: Bool {
        _head == _tail
    }

    public init(capacity: Int) {
        _contents = [T]()
        _contents.reserveCapacity(capacity)
    }

    public mutating func enqueue(_ value: T) {
        let isFull = self.isFull
        if isFull && _head > 0 && _head != _count {
            realign()
        }

        if isFull && _head == 0 {
            _contents.append(value)
        } else {
            _contents[_tail] = value
            _tail = (_tail + 1) % _count
        }
    }

    @discardableResult
    public mutating func dequeue() -> T? {
        guard count > 0 else { return nil }
        _head %= _count
        defer {
            _head += 1
        }
        return _contents[_head]
    }

    public func peek() -> T? {
        guard count > 0 else { return nil }
        return _contents[_head]
    }

    public mutating func clear(_ releaseMemory: Bool = true) {
        _head = 0
        _tail = 0

        _contents.removeAll(keepingCapacity: !releaseMemory)
    }
    
    public mutating func resize(capacity newCapacity: Int) {
        precondition(newCapacity >= count, "new capacity must be greater than or equal to current count")
        _contents.reserveCapacity(newCapacity)
    }

    private mutating func realign() {
        let size = MemoryLayout<T>.stride
        let isFirst = _count - _head <= _tail + 1
        let temp = malloc(size * (isFirst ? _count - _head : _tail + 1))
        if isFirst {
            memcpy(temp, &_contents + _head * size, size * (_count - _head))
            memcpy(&_contents + (_count - _head) * size, _contents, size * (_tail + 1))
            memcpy(&_contents, temp, size * (_count - _head))
        } else {
            memcpy(temp, _contents, size * (_tail + 1))
            memcpy(&_contents, &_contents + _head * size, size * (_count - _head))
            memcpy(&_contents + size * (_count - _head), temp, size * (_tail + 1))
        }
        _head = 0
        _tail = 0
    }
}

extension Queue: CustomStringConvertible {
    @inline(__always)
    private func createString(_ elements: ArraySlice<T>...) -> String {
        elements.flatMap{ $0 }.description
    }

    public var description: String {
        return _isContinuous
            ? _contents[_head..<_count].description
            : createString(_contents[_head...], _contents[..<_tail])
    }
}

extension Queue: ExpressibleByArrayLiteral {

    public typealias ArrayLiteralElement = T

    public init(arrayLiteral elements: T...) {
        self.init(elements)
    }

    public subscript(_ index: Int) -> T {
        get {
            let i = (_head + index) % _count
            guard i < count else { fatalError("Index out of bounds") }
            return _contents[(_head + index) % _count]
        }
        set {
            _contents[(_head + index) % _count] = newValue
        }
    }
}

extension Queue: Sequence {
    public typealias Element = T

    public typealias Iterator = AnyIterator<T>

    public __consuming func makeIterator() -> AnyIterator<T> {
        AnyIterator(IndexingIterator(_elements: _contents.lazy))
    }

    public init<S: Sequence>(_ elements: S) where S.Iterator.Element == T {
        _contents = [T].init(elements)
    }
}
