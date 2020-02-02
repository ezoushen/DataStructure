//
//  Stack.swift
//  DataStructure
//
//  Created by ezou on 2020/2/1.
//

import Foundation

public struct Stack<T> {
    private var _contents: [T]
    
    private(set) public var count: Int = 0
    
    public var capacity: Int {
        _contents.capacity
    }
    
    public var isEmpty: Bool {
        return _contents.isEmpty
    }
    
    public init() {
        _contents = [T]()
    }
    
    public init(capacity: Int) {
        self.init()
        _contents.reserveCapacity(capacity)
    }
    
    @discardableResult
    public mutating func pop() -> T? {
        guard count > 0 else { return nil }
        count -= 1
        return _contents[count]
    }
    
    public func peek() -> T? {
        guard count > 0 else {
            return nil
        }
        return _contents[count - 1]
    }
    
    public mutating func push(_ value: T) {
        _contents.append(value)
        count += 1
    }
    
    public mutating func resize(capacity newCapacity: Int) {
        precondition(newCapacity > count, "new capacity must be greater than current count")
        _contents.reserveCapacity(newCapacity)
    }
    
    public mutating func clear(_ releaseMemory: Bool = true) {
        count = 0
        
        guard releaseMemory else { return }
        _contents = [T]()
    }
}

extension Stack: CustomStringConvertible {
    public var description: String {
        return _contents[...(count-1)].description
    }
}

extension Stack: ExpressibleByArrayLiteral {
    
    public typealias ArrayLiteralElement = T
    
    public init(arrayLiteral elements: T...) {
        self.init(elements)
    }
    
    public subscript(_ index: Int) -> T {
        get {
            guard index < count else { fatalError("Index out of bounds") }
            return _contents[index]
        }
        set {
            _contents[index] = newValue
        }
    }
}

extension Stack: Sequence {
    public typealias Element = T
    
    public typealias Iterator = AnyIterator<T>
    
    public __consuming func makeIterator() -> AnyIterator<T> {
        AnyIterator(IndexingIterator(_elements: _contents.lazy))
    }
    
    public init<S: Sequence>(_ elements: S) where S.Iterator.Element == T {
        _contents = [T](elements)
        count = _contents.count
    }
}
