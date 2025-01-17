//
//  AlbumRow.swift
//  German Music
//
//  Created by Andrei Kindziayeu on 17.01.25.
//

import SwiftUI

struct AlbumRow: View {
    private let album: Album
    private let rotateClockwise: Bool
    @Binding private var isFavourite: Bool
    private let onAction: () -> Void
    
    init(
        album: Album,
        rotateClockwise: Bool,
        isFavourite: Binding<Bool>,
        onAction: @escaping () -> Void
    ) {
        self.album = album
        self.rotateClockwise = rotateClockwise
        _isFavourite = isFavourite
        self.onAction = onAction
    }
    
    var body: some View {
        HStack(spacing: 0) {
            artwork
            VStack(spacing: 16) {
                caption
                genres
            }
        }
        .padding(16)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(.albumRowBorder , lineWidth: 1)
        }
        .shadow(color: .albumRowShadow1, radius: 2, x: 0, y: 1)
        .shadow(color: .albumRowShadow2, radius: 6, x: 0, y: 4)
    }
    
    private var artwork: some View {
        AsyncImage(url: album.artworkURL) { image in
            image
                .resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 128, height: 128)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(4)
        .background(.imageFrame)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .frameShadow, radius: 4, x: 0, y: 1)
        .rotationEffect(.degrees(rotateClockwise ? 5 : -5))
        .padding(10)
    }
    
    private var caption: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                Text(album.title)
                    .lineLimit(2)
                    .font(.title2)
                    .foregroundStyle(.text)
                Text(album.artistName)
                    .lineLimit(1)
                    .font(.body)
                    .foregroundStyle(.secondaryText)
            }
            Spacer(minLength: 0)
            Image(systemName: "chevron.right.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundStyle(.chevronArrow, .chevronCircle)
        }
    }
    
    private var genres: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                genre(index: 0)
                genre(index: 2)
            }
            Spacer(minLength: 8)
            VStack(alignment: .trailing, spacing: 8) {
                genre(index: 1)
                FavouriteView(isFavourite: $isFavourite)
            }
        }
    }
    
    @ViewBuilder
    private func genre(index: Int) -> some View {
        if album.genres.count > index {
            GenreView(name: album.genres[index].name)
        } else {
            GenreView(name: "")
                .hidden()
        }
    }
}
