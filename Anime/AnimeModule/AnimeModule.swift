//
//  AnimeModule.swift
//  Anime
//
//  Created by John Ayres on 1/21/21.
//
//  Copyright © 2023 John Ayres. Licensed under MIT License.

import Foundation
import UIKit
import SwiftUI
import Combine

/**
 The AnimeModule provides functionality to search for information about anime.
 */
final class AnimeModule: ModuleProtocol
{    
    typealias View = AnimeView
    typealias Presenter = AnimePresenter
    typealias Router = AnimeRouter
    typealias Interactor = AnimeInteractor

    /**
     Builds the Anime VIPER module.
     
     A production application would implement this functionality much differently. The `Module` object itself would be would be tracked, and the actual assemblage of said module would be handled by one or more classes that implement the Builder pattern, possibly employing one or more classes implementing the Abstract Factory and Factory Method patterns. I almost implemented a Builder for this exercise, but I felt like that would be over-engineering such a simple app.
     
     - Returns: A `View` object.
     */
    func build() -> View
    {
        // Load our configuration. This could be changed depending on our environment or device
        let configuration = Configuration(configurationFile: "PRODConfiguration")
        
        // Create the data service. This provides data via a network call, but could be something that retrieves it from CoreData. We inject the Configuration dependency.
        let dataService = AnimeDataServiceNetwork(configuration: configuration)
        
        // Create the view model
        let viewModel = AnimeListViewModel()
        
        // Create the Interactor object, injecting the DataService dependency.
        let interactor = Interactor(dataService: dataService)
        
        // Create the other VIPER objects
        let presenter = Presenter()
        let router = Router()

        // Finally create the `View` object
        let view = View(viewModel: viewModel, presenter: presenter)
        
        // Wire everything together
        presenter.viewModel = viewModel
        self.assembleParts(presenter: presenter, router: router, interactor: interactor)
        
        return view
    }
}
