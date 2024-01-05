//
//  NetworkService.swift
//  Anime
//
//  Created by John Ayres on 1/21/21.
//
//  Copyright © 2023 John Ayres. Licensed under MIT License.

import Foundation

/**
 Provides access to anime data.
 */
protocol AnimeDataService: AnyObject
{
    /**
     Retrieves anime data, performing a search on the given search term.
     
     - Parameters:
        - for: The term to search upon.
        - onComplete: A block that is called when the search is complete.
        - result: If successful, this contains a `Result` object that has an `AnimeResponseEntity` object in its .success enumeration. Otherwise, the .failure enumeration contains an `Error` object with a detailed error message.
     */
    func getData(for searchTerm: String, onComplete: @escaping (_ result: Result<AnimeResponseEntity, Error>) -> ())
}


/**
 This concrete implementation of `AnimeDataService` retrieves anime data from a network end point.
 */
final class AnimeDataServiceNetwork: AnimeDataService
{
    // MARK: - Private Properties
    private let configuration: Configuration
    
    
    //MARK: - Constructor
    
    /**
     Returns a newly initialized `AnimeDataServiceNetwork` object.
     
     - Parameters:
        - configuration: A `Configuration` object containing configuration data (another implementation of dependency injection).
     
     - Returns: A newly initialized `AnimeDataServiceNetwork` object.
     */
    init(configuration: Configuration)
    {
        self.configuration = configuration
    }
    
    
    // MARK: - Methods
    
    func getData<T: Codable>(for searchTerm: String, onComplete: @escaping (Result<T, Error>) -> ())
    {
        if let animeEndPoint = configuration.animeEndpoint {
            let urlString = animeEndPoint + "?q=\(searchTerm)"
            
            if let url = URL(string: urlString) {
                URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    // in a production app, we would log detailed error information to something like App Center for proper analysis, but
                    // in this simple example we're just printing it out to the debug output.
                    if let error = error {
                        print(error)
                        onComplete(.failure(error))
                        return
                    }
                    
                    guard let data = data else {
                        let error = NetworkError(localizedErrorDescription: "No data returned.")
                        print(error)
                        onComplete(.failure(error))
                        return
                    }
                    
                    // decode the JSON result
                    do {
                        let decoder = JSONDecoder()
                        let animeResponse = try decoder.decode(T.self, from: data)
                        onComplete(.success(animeResponse))
                    } catch (let error) {
                        print("Error: \(error)")
                    }

                }).resume()
            }
        } else {
            // invalid configuration data should never make it into an application, and proper unit testing would find this very quickly, so I don't
            // think it's inappropriate to use fatalError here
            fatalError("Configuration for anime endpoint is invalid")
        }
    }    
}


