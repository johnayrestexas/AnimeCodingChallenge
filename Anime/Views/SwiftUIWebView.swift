//
//  SwiftUIWebView.swift
//  Anime
//
//  Created by John Ayres on 1/21/21.
//
//  Copyright © 2023 John Ayres. Licensed under MIT License.

import WebKit
import SwiftUI

/**
 This class provides the functionality to use WKWebView in a SwiftUI View.
 
 SwiftUI is still in its infancy and as of this writing it does not offer a SwiftUI version of everything found in UIKit. In order to display web pages in a SwiftUI application, we must create a wrapper around WKWebView. This is a very minimal wrapper providing only the most basic functionality of WKWebView. In an actual production application, this would be a complete implementation, but for this example application such functionality was unnecessary.
 */
struct SwiftUIWebView: UIViewRepresentable
{
    typealias UIViewType = WKWebView
    
    let url: URL?

    func makeUIView(context: Context) -> WKWebView
    {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context)
    {
        if let url = url {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}
