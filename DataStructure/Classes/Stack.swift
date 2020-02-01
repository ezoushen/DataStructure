//
//  Stack.swift
//  DataStructure
//
//  Created by ezou on 2020/2/1.
//

import Foundation

public struct Stack<T> {
    private var _contents: [T]
    
    private(set) public var count: Int
    
    private(set) public var capacity: Int {
        didSet {
            _contents.reserveCapacity(capacity)
        }
    }
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public var isFull: Bool {
        return capacity == count
    }
    
    public init(capacity: Int) {
        self.count = 0
        self.capacity = capacity
        
        _contents = [T]()
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
        if isFull {
            resize(capacity: count * 2)
        }
        
        _contents.append(value)
        count += 1
    }
    
    public mutating func resize(capacity newCapacity: Int) {
        capacity = newCapacity
    }
    
    public mutating func trim() {
        resize(capacity: max(1, count))
    }
    
    public mutating func clear(_ releaseMemory: Bool = true) {
        count = 0
        
        guard releaseMemory else { return }
        _contents = [T]()
        capacity = 1
    }
}

extension Stack: CustomStringConvertible {
    public var description: String {
        return _contents[...(count-1)].description
    }
}
