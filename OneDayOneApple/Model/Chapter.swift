//
//  Chapter.swift
//  OneDayOneApple
//
//  Created by Dasan on 2023/10/16.
//

import Foundation

struct Chapter {
    let id = UUID()
    var title: String
    var sections: [Section]
    var isComplete: Bool
}

struct Section {
    let id = UUID()
    let title: String
    let subTitle: String? = nil
    var isComplete: Bool
}

struct ContentItem: Hashable, Identifiable {
    var id: UUID =  UUID()
    var title: String
    var subContent: [ContentItem]? = nil
    var isComplete: Bool
}
