//
//  HomeView.swift
//  chinese idiom of the day Watch App
//
//  Created by George Li on 11/25/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 4) {
                NavigationLink(destination: LikesView()) {
                    HStack(alignment: .firstTextBaseline) {
                        Text("Favorites").foregroundColor(.white)
                    }
                }
                .buttonStyle(CustomButtonStyle())
                Spacer()
                Text("App Version: \(VersionInfo.appVersion)")
                    .foregroundColor(Color(hex: "#676767"))
                    .font(.footnote)
            }
            .padding()
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
// Custom button style for reusable styling
struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(Color(hex: "#676767"))
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color(hex:"#222223"))
            .cornerRadius(8)
    }
}

#Preview {
    HomeView()
}
