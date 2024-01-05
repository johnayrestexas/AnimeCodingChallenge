//
//  AnimeInteractor.swift
//  Anime
//
//  Created by John Ayres on 1/21/21.
//
//  Copyright © 2023 John Ayres. Licensed under MIT License.

import Foundation

/**
 Provides `Interactor` functionality for the Anime VIPER module.
 */
final class AnimeInteractor: InteractorProtocol
{
    // MARK: - Public Properties
    
    /// Gets or sets the `Presenter`.
    weak var presenter: AnimePresenter!
    
    
    // MARK: - Private Properties
    fileprivate let dataService: AnimeDataService
    
    
    // MARK: - Constructors
    
    /**
     Returns a newly initialized `AnimeInteractor` object.
     
     Data access is provided via a `AnimeDataService` protocol provided to this constructor. This is the most basic implementation of dependency injection (and represents the 'D' in SOLID for 'dependency inversion'). In a production application, this would allow us to mock up a fake data provider for unit testing purposes, or provide a different implementation that retrieves data from a database rather than a network call, etc.
     
     - Parameters:
        - dataService: An object the implements the `AnimeDataService` protocol.
     
     - Returns: A newly initialized `AnimeInteractor` object.
     */
    init(dataService: AnimeDataService)
    {
        self.dataService = dataService
    }
    
    
    // MARK: - Methods
    
    /**
     Requests data about an anime character, and notifies the presenter upon completion.
     
     - Parameters:
        - for: The name of an anime character.
     */
    func requestData(for animeCharacter: String)
    {
        // Note: The `Interactor' knows that the retrieved data may come in on a background thread, so it marshals the return calls to the main thread
        // since the `Presenter' will be updating the UI
        dataService.getData(for: animeCharacter) { [weak self] (result) in
            switch result {
            case .failure:
                // The implementing data service should have logged an appropriate error message, but this is likely very technical so we should provide a more
                // user-friendly error message. In a production application, this would be localized.
                DispatchQueue.main.async {
                    self?.presenter.display(errorMessage: "No results found")
                }
                
            case .success(let response):
                // we may have a successful response, but one without any actual entries, so display accordingly
                DispatchQueue.main.async {
                    if response.data.count > 0 {
                        self?.presenter.display(entities: response.data)
                    } else {
                        self?.presenter.display(errorMessage: "No results found")
                    }
                }
            }
        }
    }
}
