//
//  AsyncImage.swift
//  Anime
//
//  Created by John Ayres on 1/21/21.
//
//  Copyright © 2023 John Ayres. Licensed under MIT License.

import SwiftUI

/**
 Provides an `Image` with a default placeholder that is replaced with an actual image after asynchronously downloading said image from a `URL`.
 
 Full disclosure: This code is adopted from https://www.vadimbulavin.com/asynchronous-swiftui-image-loading-from-url-with-combine-and-swift/
 
 I've written something similar for UIKit UIImages, but I hadn't done the same with SwiftUI until this exercise. I'm still learning SwiftUI, and after doing some research this seemed like the most elegant, SwiftUI'ish way to perform this functionality. Thus, like every developer ever, I shamelessly copied this from from a blog post (we all do this, StackOverflow anyone?). The above is a very good read, and expanded my knowledge of Combine and SwiftUI.
 
 Given more time, I would have implemented image caching as well.
 */
struct AsyncImage: View {
    
    // using StateObject here as we want the view to manage the loader's lifetime; loader is kept alive as long as AsyncImage is visible
    @StateObject private var loader: ImageLoader
        
    init(url: URL) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        content.onAppear(perform: loader.load)
    }
    
    private var content: some View
    {
        Group {
            if let image = loader.image {
                Image(uiImage: image).resizable()
            } else {
                Image("placeholder").resizable()
            }
        }
    }
}


struct AsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImage(url: URL(string: "https://NotUsedByPreview.com")!)
    }
}

