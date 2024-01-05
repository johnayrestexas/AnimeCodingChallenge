//
//  Pagination.swift
//  Anime
//
//  Created by John Ayres on 1/2/24.
//
//  Copyright © 2023 John Ayres. Licensed under MIT License.

import Foundation

struct Pagination: Codable {
    let lastVisiblePage: Int?
    let hasNextPage: Bool?
    let currentPage: Int?
    let items: PaginationItem?
    
    enum CodingKeys: String, CodingKey {
        case lastVisiblePage = "last_visible_page"
        case hasNextPage = "has_next_page"
        case currentPage = "current_page"
        case items
    }
}

struct PaginationItem: Codable {
    let count: Int?
    let total: Int?
    let perPage: Int?
    
    enum CodingKeys: String, CodingKey {
        case count
        case total
        case perPage = "per_page"
    }
}
