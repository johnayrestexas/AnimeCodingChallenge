//
//  PresenterProcol.swift
//  Anime
//
//  Created by John Ayres on 1/21/21.
//
//  Copyright © 2023 John Ayres. Licensed under MIT License.

import Foundation

/**
 The Presenter in a VIPER module contains the user interface related (but user interface library independent) business logic. It owns and asks for updates from the Interactor. It is also aware of the Router so it can seque into other VIPER modules. The Presenter updates the View.
 
 Note: In a UIKit implementation of VIPER, the Presenter would have knowledge of the View. However, the SwiftUI preferred way of updating the view is through the various binding property wrappers and related functionality provided by Combine. Therefore, this implementation of the Presenter does not have direct knowledge of the View. The concrete implementation of this protocol will have a view model that uses Combine to perform updates to the View.
 */
protocol PresenterProtocol: AnyObject
{
    associatedtype RouterProtocol
    associatedtype InteractorProtocol

    /// Gets or sets the Router.
    var router: RouterProtocol! { get set }
    
    /// Gets or sets the Interactor.
    var interactor: InteractorProtocol! { get set }
}
