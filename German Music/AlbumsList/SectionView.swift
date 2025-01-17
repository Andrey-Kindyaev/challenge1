//
//  SectionView.swift
//  German Music
//
//  Created by Andrei Kindziayeu on 17.01.25.
//

import SwiftUI

struct SectionView: View {
    @Binding private var isActive: Bool
    
    private let title: String
    private let count: Int
    
    init(title: String, count: Int, isActive: Binding<Bool>) {
        self.title = title
        self.count = count
        _isActive = isActive
    }
    
    var body: some View {
        HStack(spacing: 1) {
            Text(title)
                .font(.sectionTitle)
                .foregroundStyle(.text)
                .opacity(isActive ? 1 : 0.4)
            Circle()
                .foregroundStyle(.sectionBadge)
                .frame(width: 24, height: 24)
                .overlay {
                    Text("\(count)")
                        .font(.sectionBadge)
                        .foregroundStyle(.text)
                }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if !isActive {
                isActive = true
            }
        }
    }
}

#Preview {
    SectionView(title: "Hello", count: 10, isActive: .constant(true))
}
