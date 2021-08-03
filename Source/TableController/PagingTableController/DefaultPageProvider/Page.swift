//
//  Page.swift
//  ListController
//
//  Created by Nikolai Timonin on 31.05.2021.
//

import Foundation

// MARK: - Page

public struct Page<T> {
    
    // MARK: - Public properties
    
    let items: [T]
    let hasMore: Bool
}
