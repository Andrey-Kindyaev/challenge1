//
//  FavouriteView.swift
//  German Music
//
//  Created by Andrei Kindziayeu on 17.01.25.
//

import SwiftUI

struct FavouriteView: View {
    @Binding var isFavourite: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            Image(isFavourite ? "heart.selected" : "heart.unselected")
                .resizable()
                .frame(width: 20, height: 20)
            Text(isFavourite ? "Saved" : "Add")
                .lineLimit(1)
                .font(.genreName)
                .foregroundStyle(isFavourite ? Color.favouriteText : .nonFavouriteText)
                .padding(.horizontal, 6)
        }
        .padding(2)
        .background(isFavourite ? Color.favouriteBackground : .nonFavouriteBackground)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .strokeBorder(.favouriteBorder , lineWidth: 1)
        )
        .contentShape(Capsule())
        .onTapGesture {
            isFavourite.toggle()
        }
    }
}
