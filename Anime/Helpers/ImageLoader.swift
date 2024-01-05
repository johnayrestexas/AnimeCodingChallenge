//
//  ImageLoader.swift
//  Anime
//
//  Created by John Ayres on 1/21/21.
//
//  Copyright © 2023 John Ayres. Licensed under MIT License.

import Foundation
import SwiftUI
import Combine

/**
 Asynchronously downloads an image from a `URL`.
 
 Full disclosure: This code is adopted from https://www.vadimbulavin.com/asynchronous-swiftui-image-loading-from-url-with-combine-and-swift/
 
 I've written something similar for UIKit UIImages, but I hadn't done the same with SwiftUI until this exercise. I'm still learning SwiftUI, and after doing some research this seemed like the most elegant, SwiftUI'ish way to perform this functionality. Thus, like every developer ever, I shamelessly copied this from from a blog post (we all do this, StackOverflow anyone?). The above is a very good read, and expanded my knowledge of Combine and SwiftUI.
 */
class ImageLoader: ObservableObject
{
    // MARK: - Public Properties
    
    /// Gets or sets the `Image`.
    @Published var image: UIImage?
    
    
    //MARK: - Private Properties
    private let url: URL
    private var cancellable: AnyCancellable?

    
    // MARK: - Constructor/Destructor
    
    /**
     Returns a newly initialized `ImageLoader` object.
     
     - Parameters:
        - url: The `URL` from which an image is downloaded.
     
     - Returns: A newly initialized `ImageLoader` object.
     */
    init(url: URL)
    {
        self.url = url
    }

    deinit
    {
        cancel()
    }
    
    
    // MARK: - Methods
    
    /// Performs the asynchronous download of the image.
    func load()
    {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.image = $0 }
    }

    /// Cancels a download.
    func cancel()
    {
        cancellable?.cancel()
    }
}
