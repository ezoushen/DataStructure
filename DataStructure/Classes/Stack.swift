//
//  Stack.swift
//  DataStructure
//
//  Created by ezou on 2020/2/1.
//

import Foundation

public struct Stack<T> {
    private var _contents: [T?]
    
    private(set) public var count: Int
    
    private(set) public var capacity: Int
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public var isFull: Bool {
        return capacity == count
    }
    
    public init(capacity: Int) {
        self.count = 0
        self.capacity = capacity
        
        _contents = [T?](repeating: nil, count: capacity)
    }
    
    public mutating func pop() throws -> T? {
        guard count > 0 else { return nil }
        guard let value = _contents[count - 1] else {
            throw Error.valueUnset
        }
        _contents[count - 1] = nil
        count -= 1
        return value
    }
    
    public func peek() -> T? {
        guard count > 0, let value = _contents[count - 1] else {
            return nil
        }
        return value
    }
    
    public mutating func push(_ value: T) {
        if isFull {
            resize(capacity: count * 2)
        }
        
        _contents[count] = value
        count += 1
    }
    
    public mutating func resize(capacity: Int) {
        var newArray = [T?](repeating: nil, count: capacity)
        memcpy(&newArray,
               _contents,
               capacity * MemoryLayout<T>.alignment)
        _contents = newArray
        self.capacity = capacity
    }
}
