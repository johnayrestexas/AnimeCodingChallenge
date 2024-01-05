//
//  InteractorProtocol.swift
//  Anime
//
//  Created by John Ayres on 1/21/21.
//
//  Copyright © 2023 John Ayres. Licensed under MIT License.

import Foundation

/**
 The Interactor in a VIPER module contains the business logic related to data and networking. It provides updates to the Presenter, knows about data Entities, and is effectively the data access layer. The concrete implementation may have knowledge of additional services to provide all the necessary functionality.
 */
protocol InteractorProtocol: AnyObject
{
    associatedtype PresenterProtocol

    /// Gets or sets the Presenter.
    var presenter: PresenterProtocol! { get set }
}
