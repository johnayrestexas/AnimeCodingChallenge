//
//  Anime.swift
//  Anime
//
//  Created by John Ayres on 1/21/21.
//
//  Copyright © 2023 John Ayres. Licensed under MIT License.

import Foundation

/**
 Entity that represents an individual entry from the anime database.
 */
struct AnimeEntity: Codable, Identifiable
{
    let id: Int
    let url: String
    let images: Images
    let trailer: Trailer
    let aired: Aired?
    let title: String
    let type: String?
    let source: String
    let airing: Bool
    let synopsis: String?
    let episodes: Int?
    let status: String
    let score: Double?
    let startDate: String?
    let endDate: String?
    let members: Int
    let duration: String
    let rating: String?
    let rank: Int?
    let popularity: Int
    let background: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case url
        case images
        case trailer
        case aired
        case title
        case airing
        case synopsis
        case type
        case source
        case episodes
        case status
        case score
        case startDate = "start_date"
        case endDate = "end_date"
        case members
        case duration
        case rating
        case rank
        case popularity
        case background
    }
}

struct Images: Codable {
    let jpg: JPEGImages
}

struct JPEGImages: Codable {
    let imageURL: String
    let smallImageURL: String?
    let largeImageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case largeImageURL = "large_image_url"
    }
}

struct Trailer: Codable {
    let youtubeID: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case youtubeID = "youtube_id"
        case url
    }
}

struct Aired: Codable {
    let from: String?
    let to: String?
    let string: String
    
    enum CodingKeys: String, CodingKey {
        case from
        case to
        case string
    }
}
