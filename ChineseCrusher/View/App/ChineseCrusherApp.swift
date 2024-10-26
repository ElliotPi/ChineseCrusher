//
//  SpanishCrusherApp.swift
//  SpanishCrusher
//
//  Created by IS 543 on 10/25/24.
//

import SwiftUI

@main
struct ChineseCrusherApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(languageViewModel: LanguageViewModel())
        }
    }
}
