//
//  AlbumRemoteRepository.swift
//  German Music
//
//  Created by Andrei Kindziayeu on 17.01.25.
//

import Foundation

final class AlbumRemoteRepository {
    func albumsList() async throws -> [Album] {
        let url = URL(string: "https://rss.marketingtools.apple.com/api/v2/us/music/most-played/100/albums.json")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(AlbumsListResponse.self, from: data).albums
    }
}
