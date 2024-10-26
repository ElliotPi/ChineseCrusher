//
//  LanguageModel.swift
//  ChineseCrusher
//
//  Created by IS 543 on 10/25/24.
//

import Foundation

protocol LessonPlan{
    var languageName: String { get }
    var topics: [Language.Topic] { get }
    var progress: [Language.Progress] { get set }
    
    mutating func toggleLessonRead(for title: String);
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
        let answers: [String]
        let correctAnswer: String
    }
    
    struct Progress {
        let topicTitle: String
        var lessonRead = false
        var vocabularyStudied = false
        var quizPassed = false
        var quizHighScore: Int?
    }
}

extension Language.Progress: Identifiable {
    var id: String { topicTitle }
}

private func key(for title: String, type: String) -> String{
    "\(title).\(type)"
}

struct ChineseLessonPlan: LessonPlan {
    
    // MARK: - Read-Only properties
    
    let languageName = "Chinese"
    let topics = Data.chineseTopics
    
    // MARK: - Mutable properties
    
    var progress: [Language.Progress] = ChineseLessonPlan.readProgressRecords()
    
    // Mark: - Helpers
    
    mutating func toggleLessonRead(for title: String) {
        if let index = progress.firstIndex(where: { $0.topicTitle == title}) {
            progress[index].lessonRead.toggle()
            UserDefaults.standard
                .set(
                    progress[index].lessonRead,
                    forKey: key(for: title, type: Key.lessonRead)
                )
        } else {
            progress.append(Language.Progress(topicTitle: title))
            toggleLessonRead(for: title)
        }
    }
    
    //TODO
    
    private static func readProgressRecords() -> [Language.Progress]{
        var progressRecords = [Language.Progress]()
        
        Data.chineseTopics.forEach { topic in
            var progressRecord = Language.Progress(topicTitle: topic.title)
            
            progressRecord.lessonRead = UserDefaults.standard.bool(
                forKey: key(for: topic.title, type: Key.lessonRead)
            )
             //TODO: Impliment this for the other three progress items
            
            progressRecords.append(progressRecord)
        }
        
        return progressRecords
    }
    
    // MARK: - Constants
    
    private struct Key {
        static let lessonRead = "lesson"
        static let vocabularyStudied = "vocab"
        static let quizPassed = "quiz"
        static let highScore = "score"
    }
    
    private struct Data {
        static let chineseTopics = [
            Language.Topic(
                title: "Basic Greetings and Farewells",
                lessonText: """
                    Here are some basic greetings and farewells that will help you interact with people on a daily basis. \
                    Common greetings include saying hello or goodbye, or asking \
                    how the other person is doing.
                    """,
                vocabulary: [
                    Language.Term(word: "你好", translation: "Hello"),
                    Language.Term(word: "掰掰", translation: "Goodbye"),
                    Language.Term(word: "早安", translation: "Good morning"),
                    Language.Term(word: "午安", translation: "Good afternoon"),
                    Language.Term(word: "晚安", translation: "Good night"),
                    Language.Term(word: "最近好嗎？", translation: "How are you?"),
                    Language.Term(word: "還不錯", translation: "I am fine"),
                    Language.Term(word: "再見", translation: "See you later")
                ],
                quiz: [
                    Language.QuizItem(
                        question: "People say 早安 to greet each other in the evening.",
                        answers: ["Yes", "No"],
                        correctAnswer: "No"
                    ),
                    Language.QuizItem(
                        question: "You could say 你好 to greet others whenever.",
                        answers: ["Yes", "No"],
                        correctAnswer: "Yes"
                    ),
                    Language.QuizItem(
                        question: "再見 means I am fine.",
                        answers: ["Yes", "No"],
                        correctAnswer: "No"
                    ),
                    Language.QuizItem(
                        question: "午安 menas good afternoon",
                        answers: ["Yes", "No"],
                        correctAnswer: "Yes"
                    ),
                    Language.QuizItem(
                        question: "不錯 means how are you.",
                        answers: ["Yes", "No"],
                        correctAnswer: "No"
                    ),
                ]
            ),
            Language.Topic(
                title: "Common Phrases",
                lessonText: """
                    Here are phrases that will help you interact with people on a daily basis.
                    """,
                vocabulary: [
                    Language.Term(word: "請", translation: "Please"),
                    Language.Term(word: "謝謝", translation: "Thank you"),
                    Language.Term(word: "不客氣", translation: "You're welcome"),
                    Language.Term(word: "抱歉", translation: "I'm sorry"),
                    Language.Term(word: "這要多少錢？", translation: "How much does itcost?"),
                    Language.Term(word: "...在哪裡?", translation: "Where is...?"),
                    Language.Term(word: "我想...", translation: "I would like")
                ],
                quiz: [
                    Language.QuizItem(
                        question: "不客氣 is the proper response when people say thank you.",
                        answers: ["Yes", "No"],
                        correctAnswer: "Yes"
                    ),
                    Language.QuizItem(
                        question: "抱歉 means thank you.",
                        answers: ["Yes", "No"],
                        correctAnswer: "No"
                    ),
                    Language.QuizItem(
                        question: "You can say 這要多少錢？ while asking for the price of something.",
                        answers: ["Yes", "No"],
                        correctAnswer: "Yes"
                    ),
                    Language.QuizItem(
                        question: "When is the restroom? == Restroom 在哪裡?",
                        answers: ["Yes", "No"],
                        correctAnswer: "Yes"
                    ),
                    Language.QuizItem(
                        question: "When someone helps you, you should say 謝謝",
                        answers: ["Yes", "No"],
                        correctAnswer: "Yes"
                    ),
                ]
            ),
        ]
    }
}
