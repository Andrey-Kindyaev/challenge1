//
//  Album.swift
//  German Music
//
//  Created by Andrei Kindziayeu on 17.01.25.
//

import Foundation

struct Album: Identifiable, Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case title = "name"
        case artistName
        case artworkURL = "artworkUrl100"
        case albumURL = "url"
        case genres
    }
    
    struct Genre: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id = "genreId"
            case name
        }
        
        let id: String
        let name: String
    }
    
    let id: String
    let title: String
    let artistName: String
    let artworkURL: URL
    let albumURL: URL
    let genres: [Genre]
}
