//
//  Configuration.swift
//  Anime
//
//  Created by John Ayres on 1/22/21.
//
//  Copyright © 2023 John Ayres. Licensed under MIT License.

import Foundation

/**
 Provides configuration information.
 
 We want to avoid hard-coding things such as URLs and what not. This class allows us to store this information in an external `plist`, centralizing all of our configuration data. We could then detect our running environment (i.e. if we're in debug or release) and load a different configuration as necessary.
 
 In a production application, there would be multiple plists for QA, Dev, Release, etc., and lots of different configuration values. This small example didn't need much configuration data, so this implementation is very basic.
 */
class Configuration
{
    // MARK: - Private Properties
    private var configuration: [String:Any]?
    
    
    // MARK: - Public Properties
    
    /// Gets the RESTful endpoint for anime data (read-only).
    var animeEndpoint: String? {
        get {
            if let configuration = configuration {
                return configuration["AnimeEndPoint"] as! String?
            } else {
                return nil
            }
        }
    }
    
    
    // MARK: - Constructors
    
    /**
     Returns a newly initialized `Configuration` object.
     
     - Parameters:
        - configurationFile: The name of the `plist` file located in the Resources group containing the desired configuration data.
     
     - Returns: A newly initialized `Configuration` object.
     */
    init(configurationFile: String)
    {
        if let plistFile = Bundle.main.path(forResource: configurationFile, ofType: "plist") {
            configuration = NSDictionary(contentsOfFile: plistFile) as? [String : Any]
        }
    }
}

