//
//  AnimePresenter.swift
//  Anime
//
//  Created by John Ayres on 1/21/21.
//
//  Copyright © 2023 John Ayres. Licensed under MIT License.

import Foundation
import Combine
import SwiftUI

/**
 Provides `Presenter` functionality for the Anime VIPER module.
 */
final class AnimePresenter: PresenterProtocol
{
    typealias RouterProtocol = AnimeRouter
    typealias InteractorProtocol = AnimeInteractor
    
    // MARK: - Public Properties
    
    /// Gets or sets the `Interactor`.
    var interactor: AnimeInteractor!
    
    /// Gets or sets the `Router'.`
    weak var router: AnimeRouter!
    
    /// Gets or sets the `AnimeListViewModel`.
    weak var viewModel: AnimeListViewModel!
    
    
    // MARK: - Private Properties
    private var searchTask: DispatchWorkItem?
    
    
    //MARK: - Methods
    
    /**
     Searchs for information about the provided anime character.
     
     This is called each time the user clicks a button on the keyboard. However, we don't want the application sending a bunch of network requests, so we delay the search by one second. This allows the user time to enter in a full search term before firing off an actual search.
     
     - Parameters:
        - for: The name of an anime character.
     */
    func search(for searchTerm: String)
    {
        // cancel the previous search
        self.searchTask?.cancel()
        
        // create a new search task
        let task = DispatchWorkItem { [weak self] in
            self?.interactor.requestData(for: searchTerm)
        }
        self.searchTask = task
        
        // delay the search by one second
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0, execute: task)
    }
    
    /**
     Displays an array of `AnimeEntity` entities.
     
     - Parameters:
        - entities: An array of `AnimeEntity` to display in the user interface.
     */
    func display(entities: [AnimeEntity])
    {
        // Note: If this was a UIKit application, this Presenter would know about the View and would update it
        // directly. In SwiftUI, this happens via the Combine framework, so we simply update view model (which is
        // essentially an implementation of MVVM).
        self.viewModel.animes = entities
    }
    
    /**
     Displays an error message; used when an error occurs during data retrieval.
     
     - Parameters:
        - error: The error message to display.
     */
    func display(errorMessage: String)
    {
        // erase all of the entities and display the error message
        self.viewModel.animes = []
        self.viewModel.errorMessage = errorMessage
    }
}
