//
//  LikesView.swift
//  chinese idiom of the day Watch App
//
//  Created by George Li on 11/25/24.
//

import SwiftUI

struct LikesView: View {
    @State private var likedIdioms: [Idiom] = []
    @ObservedObject private var favoritesManager = FavoritesManager.shared
    
    var body: some View {
        NavigationStack {
            VStack {
                if likedIdioms.isEmpty {
                    Text("You haven't liked any idioms yet.")
                        .font(.footnote)
                        .foregroundColor(Color.gray)
                } else {
                    List(likedIdioms, id: \.id) { idiom in
                        NavigationLink(destination: SingleIdiomView(idiom: idiom)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(idiom.idiom)
                                        .font(.system(size: 24))
                                        .foregroundColor(.primary)
                                    Text(idiom.translation)
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                }
                                .padding(.vertical, 4)
                                Spacer()
                            }
                            .padding(2)
                            .cornerRadius(8)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                FavoritesManager.shared.removeFavorite(id: idiom.id)
                                loadLikedIdioms() // Reload after removing
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .onAppear {
                loadLikedIdioms()
            }
        }.navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    private func loadLikedIdioms() {
        // Retrieve liked idioms from FavoritesManager
        let favoriteIds = favoritesManager.favorites
    
        if let allIdioms = loadIdiomsJSON() {
            likedIdioms = allIdioms.filter { favoriteIds.contains($0.id) }
        }
    }
}

#Preview {
    LikesView()
}
