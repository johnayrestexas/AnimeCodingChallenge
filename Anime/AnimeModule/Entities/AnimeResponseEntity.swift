//
//  AnimeResponse.swift
//  Anime
//
//  Created by John Ayres on 1/2/24.
//
//  Copyright © 2023 John Ayres. Licensed under MIT License.

import Foundation

/**
 Entity that holds data from an anime database query.
 */
struct AnimeResponseEntity: Codable
{
    let pagination: Pagination
    let data: [AnimeEntity]
}
