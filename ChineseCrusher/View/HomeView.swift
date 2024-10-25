//
//  ContentView.swift
//  SpanishCrusher
//
//  Created by IS 543 on 10/25/24.
//

import SwiftUI

struct HomeView: View {
    var languageViewModel: LanguageViewModel
    
    var body: some View {
        NavigationStack {
            List(["Numbers", "Family Members", "Colors"], id: \.self) { topic in
                    Text(topic)
            }
            .listStyle(.plain)
            .navigationTitle("Chinese Crusher")
        }
        .padding()
    }
}

#Preview {
    HomeView(languageViewModel: LanguageViewModel())
}
