//
//  AnimeListViewModel.swift
//  Anime
//
//  Created by John Ayres on 1/21/21.
//
//  Copyright © 2023 John Ayres. Licensed under MIT License.

import Combine

/**
 This `ObservableObject` implementation uses the Combine framework to provide MVVM functionality, communicating updates between the `Presenter` and `View` in the Anime module.
 */
class AnimeListViewModel: ObservableObject
{
    // MARK: - Public Properties
    let objectWillChange = ObservableObjectPublisher()
    
    /// Gets or sets the `AnimeEntity` array of entities.
    @Published var animes: [AnimeEntity] = [] {
        willSet {
            objectWillChange.send()
        }
    }
    
    /// Gets or sets the search term, used to search the anime database.
    @Published var searchTerm: String = "" {
        willSet {
            objectWillChange.send()
        }
    }
    
    /// Gets or sets a user-friendly error message.
    @Published var errorMessage: String = "" {
        willSet {
            objectWillChange.send()
        }
    }
}
