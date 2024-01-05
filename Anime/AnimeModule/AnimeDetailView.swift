//
//  DetailView.swift
//  Anime
//
//  Created by John Ayres on 1/21/21.
//
//  Copyright © 2023 John Ayres. Licensed under MIT License.

import SwiftUI

/**
 A `View` displaying details about an anime character for the Anime VIPER module.
 */
struct AnimeDetailView: View {
    var url: URL
    
    var body: some View {
        SwiftUIWebView(url: url)
            .navigationBarTitle("Details", displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let url = URL(string: "http://www.PreviewDoesntSeemToWorkWithWKWebViewSoThisDoesntMatter.com")
        AnimeDetailView(url: url!)
    }
}
