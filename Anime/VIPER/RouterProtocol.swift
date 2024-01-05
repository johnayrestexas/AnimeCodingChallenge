//
//  RouterProtocol.swift
//  Anime
//
//  Created by John Ayres on 1/21/21.
//
//  Copyright © 2023 John Ayres. Licensed under MIT License.

import Foundation

/**
 The Router in a VIPER module is responsible for seques between VIPER modules. It knows about the Presenter.
 */
protocol RouterProtocol: AnyObject
{
    associatedtype PresenterProtocol

    /// Gets or sets the Presenter.
    var presenter: PresenterProtocol! { get set }
}
