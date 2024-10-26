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
            List(languageViewModel.topics) { topic in
                Text(topic.title)
            }
            .listStyle(.plain)
            .navigationTitle("Learn \(languageViewModel.languageName)")
        }
        .padding()
    }
}

#Preview {
    HomeView(languageViewModel: LanguageViewModel())
}
