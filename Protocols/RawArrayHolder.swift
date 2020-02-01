//
//  RawArrayHolder.swift
//  DataStructure
//
//  Created by ezou on 2020/2/1.
//

import Foundation

public protocol RawArrayOperator {
    var count: Int { get }
    var capacity: Int { get }
    
    mutating func clear(_ releaseMemory: Bool)
    mutating func resize(capacity newCapacity: Int)
    mutating func trim()
}

public extension RawArrayOperator {
    mutating func trim() {
        resize(capacity: max(1, count))
    }
}
