//
//  Array+Extensions.swift
//  ResumeBuilder
//
//  Created by Rabin Joshi on 2025-04-16.
//

import Foundation

extension Array where Element: Equatable {
    /// Moves an object up one position in the array (toward index 0)
    /// - Parameter object: The object to move
    /// - Returns: Whether the move was successful
    mutating func moveUp(obj: Element) -> Bool {
        guard let currentIndex = self.firstIndex(of: obj) else {
            return false // Object not found in array
        }

        // Check if already at the top
        guard currentIndex > startIndex else {
            return false // Can't move up further
        }

        // Get the previous index and swap
        let previousIndex = index(before: currentIndex)
        self.swapAt(currentIndex, previousIndex)
        return true
    }

    /// Moves an object down one position in the array (toward the end)
    /// - Parameter object: The object to move
    /// - Returns: Whether the move was successful
    mutating func moveDown(obj: Element) -> Bool {
        guard let currentIndex = self.firstIndex(of: obj) else {
            return false // Object not found in array
        }

        // Check if already at the bottom
        guard currentIndex < index(before: endIndex) else {
            return false // Can't move down further
        }

        // Get the next index and swap
        let nextIndex = index(after: currentIndex)
        self.swapAt(currentIndex, nextIndex)
        return true
    }
}
