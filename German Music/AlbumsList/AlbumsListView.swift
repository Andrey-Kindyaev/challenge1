//
//  AlbumsListView.swift
//  German Music
//
//  Created by Andrei Kindziayeu on 17.01.25.
//

import SwiftUI

enum SectionType {
    case featured
    case favourite
}

struct AlbumsListView: View {
    @StateObject private var viewModel = AlbumsListViewModel()
    @State private var activeSectionType: SectionType = .featured
    
    var body: some View {
        let albums = self.albums
        NavigationStack {
            List {
                Section {
                    ForEach(albums.indices, id: \.self) { index in
                        let album = albums[index]
                        AlbumRow(
                            album: album,
                            rotateClockwise: index % 2 == 1,
                            isFavourite: Binding(
                                get: { viewModel.favouritesIDs.contains(album.id) },
                                set: {
                                    if $0 {
                                        viewModel.favouritesIDs.insert(album.id)
                                    } else {
                                        viewModel.favouritesIDs.remove(album.id)
                                    }
                                }
                            )
                        ) {
                            print("onAction")
                        }
                    }
                } header: {
                    HStack(spacing: 32) {
                        SectionView(
                            title: "Featured",
                            count: viewModel.featuredAlbums.count,
                            isActive: isActiveBinding(.featured)
                        )
                        SectionView(
                            title: "Saved",
                            count: viewModel.favouritesAlbums.count,
                            isActive: isActiveBinding(.favourite)
                        )
                    }
                    .textCase(nil)
                }
                .listRowSeparator(.hidden)
                .listRowSpacing(13)
            }
            .listStyle(.plain)
            .navigationTitle("Apple Music: Albums")
        }
        .searchable(text: $viewModel.searchTerm)
        .scrollContentBackground(.hidden)
        .onFirstAppear(perform: viewModel.onFirstAppear)
    }
    
    private func isActiveBinding(_ sectionType: SectionType) -> Binding<Bool> {
        Binding(
            get: { sectionType == activeSectionType },
            set: {
                if $0 {
                    activeSectionType = sectionType
                }
            }
        )
    }
    
    private var albums: [Album] {
        switch activeSectionType {
        case .featured:
            viewModel.featuredAlbums
        case .favourite:
            viewModel.favouritesAlbums
        }
    }
}
