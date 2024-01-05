//
//  AnimeListItemView.swift
//  Anime
//
//  Created by John Ayres on 1/21/21.
//
//  Copyright © 2023 John Ayres. Licensed under MIT License.

import SwiftUI

/**
 An individual item in the list of anime data.
 */
struct AnimeListItemView: View {
    let anime: AnimeEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(anime.title)
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(.accentColor)

            HStack(alignment: .top, spacing: 8) {
                if let url = URL(string: anime.images.jpg.imageURL) {
                    AsyncImage(url: url)
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }

                VStack(alignment: .leading, spacing: 8) {
                    if let synopsis = anime.synopsis {
                        Text(synopsis)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .lineLimit(5)
                            .padding(.trailing, 8)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        if let rating = anime.rating {
                            Text("Rating: \(rating)")
                                .font(.footnote)
                        }
                        
                        if let episodes = anime.episodes, episodes > 0 {
                            Text("Episodes: \(episodes)")
                                .font(.footnote)
                        }
                        
                        if let score = anime.score, score > 0.0 {
                            Text("Score: \(score, specifier: "%.1f")")
                                .font(.footnote)
                        }
                        
                        if let aired = anime.aired {
                            Text("Aired: \(aired.string)")
                                .font(.footnote)
                        }
                    } // HSTACK
                } // VSTACK
            } // HSTACK
        } // VSTACK
    }
}

struct AnimeListItemView_Previews: PreviewProvider {
    static var previews: some View {
        let url = Bundle.main.url(forResource: "anime.json", withExtension: nil)
        let data = try? Data(contentsOf: url!)
        let decoder = JSONDecoder()
        let anime = try? decoder.decode(AnimeEntity.self, from: data!)

        AnimeListItemView(anime: anime!)
            .previewLayout(.fixed(width: 700, height: 300))
            .padding()
    }
}
