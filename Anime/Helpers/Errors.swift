//
//  Errors.swift
//  Anime
//
//  Created by John Ayres on 1/21/21.
//
//  Copyright © 2023 John Ayres. Licensed under MIT License.

import Foundation

/**
 A simple implementation of `LocalizedError` for use in reporting networking errors.
 
 In a production application, there would be many different types of `Error` class, and they would be used in conjunction with localized strings to provide information in locale-specific language.
 */
struct NetworkError: LocalizedError
{
    let localizedErrorDescription: String?
    
    var errorDescription: String?
    {
        return localizedErrorDescription
    }
}
