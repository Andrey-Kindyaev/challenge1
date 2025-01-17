//
//  AlbumsListViewModel.swift
//  German Music
//
//  Created by Andrei Kindziayeu on 17.01.25.
//

import Foundation

@MainActor
final class AlbumsListViewModel: ObservableObject {
    @Published private var albums: [Album] = []
    @Published var favouritesIDs: Set<String> = []
    @Published var searchTerm: String = ""
    
    private func albumsList() async throws -> [Album] {
        let url = URL(string: "https://rss.marketingtools.apple.com/api/v2/us/music/most-played/100/albums.json")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(AlbumsListResponse.self, from: data).albums
    }
    
    var featuredAlbums: [Album] {
        albums
            .filter { album in
                guard !searchTerm.isEmpty else {
                    return true
                }
                return album.title.range(of: searchTerm, options: .caseInsensitive) != nil ||
                    album.artistName.range(of: searchTerm, options: .caseInsensitive) != nil
            }
    }
    
    var favouritesAlbums: [Album] {
        featuredAlbums
            .filter { favouritesIDs.contains($0.id) }
    }
    
    func onFirstAppear() {
        Task {
            do {
                albums = try await albumsList()
                
                print("loaded count: \(albums.count)")
            } catch {
                print("Error: \(error)")
                
                // load locally stored
            }
        }
    }
}
