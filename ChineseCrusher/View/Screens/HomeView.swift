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
                VStack(alignment: .leading){
                    Text(topic.title)
                        .font(.headline)
                    Button {
                        languageViewModel.toggleLessonRead(for: topic.title)
                    } label: {
                        Text("Lesson read: \(languageViewModel.progress(for: topic.title).lessonRead)")
                            .font(.subheadline)
                    }
                }
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
