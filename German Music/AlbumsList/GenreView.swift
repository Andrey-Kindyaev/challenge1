//
//  GenreView.swift
//  German Music
//
//  Created by Andrei Kindziayeu on 17.01.25.
//

import SwiftUI

struct GenreView: View {
    let name: String
    
    var body: some View {
        HStack(spacing: 0) {
            Image("note")
                .resizable()
                .frame(width: 20, height: 20)
            Text(name)
                .lineLimit(1)
                .font(.genreName)
                .foregroundStyle(.genreText)
                .padding(.horizontal, 6)
        }
        .padding(2)
        .background(.genreBackground)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .strokeBorder(.genreBorder, lineWidth: 1)
        )
    }
}
