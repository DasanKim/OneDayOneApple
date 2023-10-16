//
//  Chapter.swift
//  OneDayOneApple
//
//  Created by Dasan on 2023/10/16.
//

import Foundation

struct Chapter: Identifiable {
    let id = UUID()
    var title: String
    var overview: Section
    var sections: [Section]
    var isComplete: Bool
}

struct Section: Identifiable {
    let id = UUID()
    var title: String
    var paragraphs: [Paragraph]
    var isComplete: Bool
}

struct Paragraph: Identifiable {
    let id = UUID()
    var text: String
    var isTranslatable: Bool
    var translatedTextShowing: Bool = false
    var translatedText: String?

    var isTranslated: Bool {
        if let text = translatedText,
           text.isEmpty == false {
            return true
        }
        return false
    }
}
