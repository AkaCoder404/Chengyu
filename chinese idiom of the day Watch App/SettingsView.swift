//
//  SettingsView.swift
//  chinese idiom of the day Watch App
//
//  Created by George Li on 11/28/24.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @State private var counter: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("Idiom Count")
            }
            HStack {
                Button(action: {
                    withAnimation(.linear(duration: 0.2)) {
                        if counter > 0 {
                            counter -= 1
                        }
                    }
                }) {
                    Label("Add", systemImage: "arrow.down")
                }.labelStyle(.iconOnly).clipShape(.circle)
                
                Text("\(counter)").font(.system(.largeTitle, design: .monospaced))
                    .frame(alignment: .center)
                
                Button(action: {
                    withAnimation(.linear(duration: 0.2)) {
                        counter += 1
                    }
                }) {
                    Label("Add", systemImage: "arrow.up") // Use Label for text and system image
                }.labelStyle(.iconOnly).clipShape(.circle)
            }.frame(alignment: .center)
        }
    }
}
