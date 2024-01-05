//
//  ModuleProtocol.swift
//  Anime
//
//  Created by John Ayres on 1/21/21.
//
//  Copyright © 2023 John Ayres. Licensed under MIT License.

import Foundation

/**
 A VIPER module can be one screen or an entire user story (i.e. multiple screens). The Module knows about all of its different parts.
 */
protocol ModuleProtocol: AnyObject
{
    associatedtype View where View: ViewProtocol
    associatedtype Presenter where Presenter: PresenterProtocol
    associatedtype Router where Router: RouterProtocol
    associatedtype Interactor where Interactor: InteractorProtocol

    /**
     Assembles the Module, connecting the different pieces that need to know about each other.
     
     - Parameters:
        - presenter: The Presenter for this module.
        - router: The Routher for this module.
        - interactor: The Interactor for this module.
     */
    func assembleParts(presenter: Presenter, router: Router, interactor: Interactor)
}

/**
 Provides a default implementation of the `assembleParts(presenter:router:interactor)` method for implementing classes.
 */
extension ModuleProtocol
{
    func assembleParts(presenter: Presenter, router: Router, interactor: Interactor)
    {
        presenter.interactor = (interactor as! Self.Presenter.InteractorProtocol)
        presenter.router = (router as! Self.Presenter.RouterProtocol)

        interactor.presenter = (presenter as! Self.Interactor.PresenterProtocol)

        router.presenter = (presenter as! Self.Router.PresenterProtocol)
    }
}
