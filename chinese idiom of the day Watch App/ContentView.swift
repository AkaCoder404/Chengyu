//
//  ContentView.swift
//  chinese idiom of the day Watch App
//
//  Created by George Li on 11/24/24.
//

import SwiftUI

struct ContentView: View {
    @State private var idioms: [Idiom] = []
    @State private var selectedIdiomIndex: Float = 0.0
    @State private var currentScreenIndex: Float = 0.0
    @State private var isEnglishTranslation: Bool = false
    
    @FocusState private var isCrownFocused: Bool
    
    // Observe FavoritesManager
    @ObservedObject private var favoritesManager = FavoritesManager.shared
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    HStack {
                        NavigationLink(destination: HomeView()) {
                            Text("General")
                                .font(.footnote)
                                .foregroundColor(Color(hex: "#676767"))
                        }.buttonStyle(.plain)
                        Spacer()
                        if isEnglishTranslation {
                            Text("英文").font(.footnote).foregroundColor(Color(hex: "#676767"))
                        } else {
                            Text("中文").font(.footnote).foregroundColor(Color(hex: "#676767"))
                        }
                    }
                    Spacer()
                    
                    HStack {
                        if idioms.isEmpty {
                            Text("Loading idioms...")
                        } else {
                            // Left VStack for idiom text and examples
                            VStack(alignment: .leading) {
                                if Int(currentScreenIndex) == 0 {
                                    VStack(alignment: .leading) {
                                        Text(idioms[Int(selectedIdiomIndex)].pinyin.trimmingCharacters(in: .whitespaces))
                                            .font(.system(size: 12))
                                            .foregroundColor(Color(hex: "#676767"))
                                        Text(idioms[Int(selectedIdiomIndex)].idiom)
                                            .font(.system(size: 24))
                                        Text(idioms[Int(selectedIdiomIndex)].translation)
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                    }
                                } else {
                                    let examples = idioms[Int(selectedIdiomIndex)].examples
                                    VStack(alignment: .leading) {
                                        Text(idioms[Int(selectedIdiomIndex)].idiom)
                                            .font(.system(size: 24))
                                        
                                        if !isEnglishTranslation {
                                            Text(examples[Int(currentScreenIndex) - 1].sentence)
                                                .font(.system(size: 12))
                                                .foregroundColor(.gray)
                                        }
                                        if isEnglishTranslation {
                                            Text(examples[Int(currentScreenIndex) - 1].translation)
                                                .font(.system(size: 12))
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading) // Take most of the available width
                            Spacer()
                            
                            // Vertical stack of circles
                            if !idioms.isEmpty {
                                VStack {
                                    ForEach(0..<idioms[Int(selectedIdiomIndex)].examples.count + 1, id: \.self) { index in
                                        Circle()
                                            .fill(index == Int(currentScreenIndex) ? Color.white : Color.gray)
                                            .frame(width: 8, height: 8)
                                    }
                                }
                                .padding(.horizontal, 5)
                            }
                        }
                    }
                    
                    Spacer()
                    HStack {
                        Text("Scroll").font(.footnote).foregroundColor(Color(hex: "#676767"))
                        Spacer()
                        Button(action: {
                            toggleFavorite(id: idioms[Int(selectedIdiomIndex)].id)
                        }) {
                            Image(systemName: !idioms.isEmpty && favoritesManager.favorites.contains(idioms[Int(selectedIdiomIndex)].id) ? "heart.fill" : "heart")
                                .foregroundColor(!idioms.isEmpty && favoritesManager.favorites.contains(idioms[Int(selectedIdiomIndex)].id) ? .red : .gray)
                        }.buttonStyle(.plain).foregroundColor(Color(hex: "#676767"))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .background(Color.black)
            .onTapGesture {
                onScreenTapGesture()
            }
        }.focusable(true)
        .focused($isCrownFocused)
        .digitalCrownAccessory(.hidden)
        .digitalCrownRotation(
            detent: $currentScreenIndex,
            from: 0,
            through: idioms.isEmpty ? 0 : Float(idioms[Int(selectedIdiomIndex)].examples.count),
            by: 1,
            sensitivity: .low,
            isContinuous: false,
            isHapticFeedbackEnabled: false,
            onChange: { _ in
                isEnglishTranslation = false
            }
        ).onAppear {
            isCrownFocused = true
            loadIdioms()
            selectedIdiomIndex = Float(Int.random(in: 0..<idioms.count))
        }
    }
    
    func loadIdioms() {
        let loadedIdioms = getDailyIdioms()
        if !loadedIdioms.isEmpty {
            idioms = loadedIdioms
        } else {
            print("Failed to load idioms")
        }
    }
    
    func onScreenTapGesture() {
        if currentScreenIndex == 0 {
            selectedIdiomIndex = Float(Int.random(in: 0..<idioms.count))
        } else {
            isEnglishTranslation = !isEnglishTranslation
        }
    }
    
    private func toggleFavorite(id: String) {
        if favoritesManager.favorites.contains(id) {
            favoritesManager.removeFavorite(id: id)
        } else {
            favoritesManager.addFavorite(id: id)
        }
    }
}

#Preview {
    ContentView()
}
