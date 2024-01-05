//
//  ViewInterface.swift
//  Anime
//
//  Created by John Ayres on 1/21/21.
//
//  Copyright © 2023 John Ayres. Licensed under MIT License.

import Foundation

/**
 The View in a VIPER module represents the user interface. It owns and sends user actions to the Presenter.
 */
protocol ViewProtocol
{
    associatedtype PresenterProtocol

    /// Gets or sets the Presenter.
    var presenter: PresenterProtocol! { get set }
}
