//
//  AnimeRouter.swift
//  Anime
//
//  Created by John Ayres on 1/21/21.
//
//  Copyright © 2023 John Ayres. Licensed under MIT License.

import Foundation
import UIKit

/**
 There is only one module in this application, so this `Router` isn't used and is provided only for completeness.
 */
final class AnimeRouter: RouterProtocol
{
    weak var presenter: AnimePresenter!
    weak var viewController: UIViewController?
}
