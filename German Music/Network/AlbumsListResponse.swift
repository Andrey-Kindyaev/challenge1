//
//  AlbumsListResponse.swift
//  German Music
//
//  Created by Andrei Kindziayeu on 17.01.25.
//

struct AlbumsListResponse: Decodable {
    private enum RootCodingKeys: String, CodingKey {
        case feed
    }
    
    private enum FeedCodingKeys: String, CodingKey {
        case results
    }
    
    let albums: [Album]
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let feedContainer = try rootContainer.nestedContainer(keyedBy: FeedCodingKeys.self, forKey: .feed)
        albums = try feedContainer.decode([Album].self, forKey: .results)
    }
}
