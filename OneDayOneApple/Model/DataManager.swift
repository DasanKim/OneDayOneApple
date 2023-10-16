//
//  DataManager.swift
//  OneDayOneApple
//
//  Created by Dasan on 2023/10/16.
//

import Foundation

final class DataManager {
    func fetchMarkdownFile() -> [Chapter] {
        guard let filePath = Bundle.main.url(forResource: "BasicOperators.md", withExtension: nil),
              let rawText = try? String(contentsOf: filePath) else {
            return DataManager.chapters
        }
        
        // 1. \n\n으로 나누기
        // 2. 주석 <!--, --> 빼기
        var rawParagraph = rawText
            .components(separatedBy: "\n\n")
            .filter { text in
                text.contains(MarkdownType.commentStart.syntax) == false && text.contains(MarkdownType.commentEnd.syntax) == false
            }
        
        // 3. code 블럭 합치기
        rawParagraph = mergeCodeBlock(rawParagraph)
        
        // 4. para \n을 spacing으로 변환하기
        rawParagraph = rawParagraph.map { text in
            if !text.hasPrefix(MarkdownType.code.syntax) {
                return text.replacingOccurrences(of: MarkdownType.newLine.syntax, with: MarkdownType.spacing.syntax)
            }
            return text
        }
        
        // 5. paragraph 구분하기
        let chapter = parse(rawParagraph)
        
        DataManager.chapters[1] = chapter
        print("break point")
        
        return DataManager.chapters
    }
}

// MARK: Private Method
extension DataManager {
    private func parse(_ rawParagraph: [String]) -> Chapter {
        var chapter: Chapter = Chapter(title: "", overview: DataManager.defaultSection, sections: [], isComplete: false)
        var sections: [Section] = []
        var section: Section = DataManager.defaultSection
        var sectionIndex = 0
        
        for paragraph in rawParagraph {
            if paragraph.hasPrefix(MarkdownType.heading1.syntax) {
                chapter.title = paragraph
                section.title = "Overview"
            } else if sectionIndex == 0 && !paragraph.hasPrefix(MarkdownType.heading2.syntax) {
                section.paragraphs.append(
                    Paragraph(
                        text: paragraph,
                        isTranslatable: checkIsTranslatable(paragraph)
                    )
                )
            } else if paragraph.hasPrefix(MarkdownType.heading2.syntax) {
                if sectionIndex != 0 {
                    sections.append(section) // 이전 섹션 저장
                } else if sectionIndex == 0 {
                    chapter.overview = section
                }
                section = Section(title: "", paragraphs: [], isComplete: false)
                section.title = paragraph
                sectionIndex += 1
            } else {
                section.paragraphs.append(
                    Paragraph(
                        text: paragraph,
                        isTranslatable: checkIsTranslatable(paragraph)
                    )
                )
            }
        }
        sections.append(section) // 마지막 섹션 저장
        chapter.sections = sections
        
        return chapter
    }
                                         
    private func checkIsTranslatable(_ text: String) -> Bool {
        if text.hasPrefix(MarkdownType.heading1.syntax) ||
            text.hasPrefix(MarkdownType.heading2.syntax) ||
            text.hasPrefix(MarkdownType.heading3.syntax) ||
            text.hasPrefix(MarkdownType.heading4.syntax) ||
            text.hasPrefix(MarkdownType.code.syntax) ||
            text.hasPrefix("Copyright (c)") {
            return false
        }
        return true
    }
    
    private func mergeCodeBlock(_ texts: [String]) -> [String] {
        var newTexts: [String] = []
        var draftText: String = ""
        
        for text in texts {
            if text.hasPrefix(MarkdownType.code.syntax) {
                if !text.hasSuffix(MarkdownType.code.syntax) {
                    draftText = text
                } else {
                    newTexts.append(text)
                }
            }
            else if !text.hasPrefix(MarkdownType.code.syntax) && text.hasSuffix(MarkdownType.code.syntax) {
                draftText += "\n\(text)"
                newTexts.append(draftText)
                draftText = ""
            }
            else {
                newTexts.append(text)
            }
        }
        
        return newTexts
    }
}

// MARK: Example Data
extension DataManager {
    static let defaultSection = Section(title: "", paragraphs: [], isComplete: false)
    
    static var chapters: [Chapter] = [
        Chapter(title: "The Basics",
                overview: Section(title: "The Basics", paragraphs: [], isComplete: true),
                sections: [
                    Section(title: "Constants and Variables", paragraphs: [], isComplete: true),
                    Section(title: "Comments", paragraphs: [], isComplete: true),
                    Section(title: "Semicolons", paragraphs: [], isComplete: true),
                    Section(title: "Integers", paragraphs: [], isComplete: true),
                    Section(title: "Floating-Point Numbers", paragraphs: [], isComplete: true),
                    Section(title: "Type Safety and Type Inference", paragraphs: [], isComplete: true),
                    Section(title: "Numeric Literals", paragraphs: [], isComplete: true),
                    Section(title: "Numeric Type Conversion", paragraphs: [], isComplete: true),
                    Section(title: "Type Aliases", paragraphs: [], isComplete: true),
                    Section(title: "Booleans", paragraphs: [], isComplete: true),
                    Section(title: "Tuples", paragraphs: [], isComplete: true),
                    Section(title: "Optionals", paragraphs: [], isComplete: true),
                    Section(title: "Error Handling", paragraphs: [], isComplete: true),
                    Section(title: "Assertions and Preconditions", paragraphs: [], isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Basic Operators",
                overview: defaultSection,
                sections: [
                    Section(title: "Terminology", paragraphs: [], isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Strings and Characters",
                overview: defaultSection,
                sections: [
                    Section(title: "String Literals", paragraphs: [], isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Collection Types",
                overview: defaultSection,
                sections: [
                    Section(title: "Mutability of Collections", paragraphs: [], isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Control Flow",
                overview: defaultSection,
                sections: [
                    Section(title: "For-In Loops", paragraphs: [], isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Functions",
                overview: defaultSection,
                sections: [
                    Section(title: "Defining and Calling Functions", paragraphs: [], isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Closures",
                overview: defaultSection,
                sections: [
                    Section(title: "Closure Expressions", paragraphs: [], isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Enumerations",
                overview: defaultSection,
                sections: [
                    Section(title: "Enumeration Syntax", paragraphs: [], isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Structures and Classes",
                overview: defaultSection,
                sections: [
                    Section(title: "Comparing Structures and Classes", paragraphs: [], isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Properties",
                overview: defaultSection,
                sections: [
                    Section(title: "Stored Properties", paragraphs: [], isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Methods",
                overview: defaultSection,
                sections: [
                    Section(title: "Instance Methods", paragraphs: [], isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Subscripts",
                overview: defaultSection,
                sections: [
                    Section(title: "Subscripts Syntax", paragraphs: [], isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Inheritance",
                overview: defaultSection,
                sections: [
                    Section(title: "Defining a Base Class", paragraphs: [], isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Initialization",
                overview: defaultSection,
                sections: [
                    Section(title: "Setting Initial Values for Stored Properties", paragraphs: [], isComplete: false),
                ],
                isComplete: false),
        
        Chapter(title: "Deinitialization",
                overview: defaultSection,
                sections: [
                    Section(title: "How Deinitialization Works", paragraphs: [], isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Optional Chaining",
                overview: defaultSection,
                sections: [
                    Section(title: "Optional Chaining as an Alternative to Forced Unwrapping", paragraphs: [], isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Error Handling",
                overview: defaultSection,
                sections: [
                    Section(title: "Representing and Throwing Errors", paragraphs: [], isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Concurrency",
                overview: defaultSection,
                sections: [
                    Section(title: "Defining and Calling Asynchronous Functions", paragraphs: [], isComplete: false),
                ],
                isComplete: false),
    ]
}
