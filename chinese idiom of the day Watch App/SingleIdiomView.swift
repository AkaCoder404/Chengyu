//
//  SingleIdiomView.swift
//  chinese idiom of the day Watch App
//
//  Created by George Li on 11/30/24.
//

import Foundation
import SwiftUI

struct SingleIdiomView: View {
    let idiom: Idiom
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(idiom.pinyin)
                    .font(.system(size: 12))
                    .foregroundColor(Color(hex: "#676767"))
                Text(idiom.idiom)
                    .font(.system(size: 24))
                Text(idiom.translation)
                    .font(.system(size: 12))
                    .foregroundColor(Color(hex: "#676767"))
                    .padding(.bottom)
                Spacer()
                
                VStack (alignment: .leading){
                    ForEach(idiom.examples.indices, id: \.self) { index in let example = idiom.examples[index]
                        VStack(alignment: .leading, spacing: 4) {
                            Text(example.sentence)
                                .font(.system(size: 14))
                            Text(example.translation)
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }.padding(.vertical, 4)
                    }
                }
            }
            
        }.navigationTitle(idiom.idiom)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SingleIdiomView(idiom: placeHolderIdiom())
}
