//
//  LanguageModel.swift
//  ChineseCrusher
//
//  Created by IS 543 on 10/25/24.
//

import Foundation

protocol LessonPlan{
    var languageName: String { get }
    var topic: [Language.Topic] { get }
    var progress: [Language.Progress] { get set }
}

struct Language {
    struct Topic: Identifiable {
        let id = UUID()
        let title: String
        let lessonText: String
        let vocabulary: [Term]
        let quiz: [QuizItem]
    }
    
    struct Term {
        let word: String
        let translation: String
    }
    
    struct QuizItem {
        let question: String
        let answer: [String]
        let correctAnswer: String
    }
    
    struct Progress {
        let topicId: UUID
        var lessonRead = false
        var vocabularyStudied = false
        var quizPassed = false
        var quizHighScore: Int?
    }
}

extension Language.Progress: Identifiable {
    var id: UUID { topicId }
}

//struct SpanishLessonPlan: LessonPlan {
//    let languageName = "Chinese"
//    let topic = [
//
//    ]
//}
