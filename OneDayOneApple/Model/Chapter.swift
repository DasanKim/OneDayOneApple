//
//  Chapter.swift
//  OneDayOneApple
//
//  Created by Dasan on 2023/10/16.
//

import Foundation

struct Chapter: Identifiable {
    let id = UUID()
    /// 요 아래 아이들은 왜때문에 var일까요?
    /// struct에서 프로퍼티를 바꾸는건 지양하는게 좋다고 생각해요
    var title: String
    var overview: Section
    var sections: [Section]
    
    var isComplete: Bool {
        sections.reduce(true) { partialResult, section in
            partialResult && section.isComplete
        }
    }
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
