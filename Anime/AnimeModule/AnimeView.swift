//
//  ContentView.swift
//  Anime
//
//  Created by John Ayres on 1/21/21.
//
//  Copyright © 2023 John Ayres. Licensed under MIT License.

import SwiftUI

/**
 A `View` displaying a search bar and a list of anime data for the Anime VIPER module.
 */
struct AnimeView: ViewProtocol, View {
    // this view model is shared with and facilitates communication with the Presenter 
    @ObservedObject var viewModel: AnimeListViewModel
    
    /// Gets or sets the `Presenter`.
    var presenter: AnimePresenter!
    
    var body: some View {
        NavigationView {
            Group {
                ZStack {
                    VStack(alignment: .center, spacing: 4) {
                        // this gives us a text field with a few icons to approximate a search bar
                        HStack {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                
                                TextField("Type a character name", text: $viewModel.searchTerm)
                                    .foregroundColor(.primary)

                                Button(action: {
                                    viewModel.searchTerm = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill").opacity(viewModel.searchTerm == "" ? 0 : 1)
                                }
                            }
                            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                            .foregroundColor(.secondary)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10.0)
                            .onChange(of: viewModel.searchTerm, perform: { value in
                                self.presenter.search(for: viewModel.searchTerm)
                            })
                        }
                        .padding(EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8))
                        
                        // the actual list of anime seasons
                        if viewModel.animes.count > 0 {
                            List {
                                ForEach(viewModel.animes) { anime in
                                    if let url = URL(string: anime.url) {
                                        NavigationLink(destination: AnimeDetailView(url: url)) {
                                            AnimeListItemView(anime: anime)
                                        }
                                    } else {
                                        AnimeListItemView(anime: anime)
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                    } // VSTACK
                    
                    // a simple error message displayed when there is no data
                    if viewModel.animes.count < 1 {
                        Text(viewModel.errorMessage.localizedCapitalized)
                    }
                } // ZSTACK
            }
            .navigationBarTitle("Anime", displayMode: .large)
        }
        .onAppear {
            self.viewModel.searchTerm = "Naruto"
            self.presenter.search(for: viewModel.searchTerm)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AnimeListViewModel()
        
        let presenter = AnimePresenter()
        presenter.viewModel = viewModel
        
        return AnimeView(viewModel: viewModel, presenter: presenter)
    }
}
