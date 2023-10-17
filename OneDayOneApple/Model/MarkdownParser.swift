//
//  MarkdownParser.swift
//  OneDayOneApple
//
//  Created by Dasan on 2023/10/17.
//

import Foundation

struct MarkdownParser {
    func fetchChapter(fileName: String) -> Chapter? {
        guard let rawText = fetchMarkdownString(fileName: fileName) else {
            return nil
        }
        
        let chapter = processingStringToChapter(rawText)
        
        //DataManager.chapters[1] = chapter
        //return DataManager.chapters
        return chapter
    }
}

// MARK: Private Method
extension MarkdownParser {
    private func fetchMarkdownString(fileName: String) -> String? {
        guard let filePath = Bundle.main.url(forResource: fileName, withExtension: nil),
              let rawText = try? String(contentsOf: filePath) else {
            return nil
        }
        
        return rawText
    }
    
    private func processingStringToChapter(_ text: String) -> Chapter {
        var draftParagraph = splitCharactersIntoStrings(by: "\n\n", text)
        
        draftParagraph = mergeCodeBlock(draftParagraph)
        
        draftParagraph = convert(MarkdownType.newLine.syntax,
                                 to: MarkdownType.spacing.syntax,
                                 paragraph: draftParagraph)
        
        let chapter = parse(draftParagraph)
        
        return chapter
    }
    
    private func splitCharactersIntoStrings(by: String, _ text: String) -> [String] {
        return text.components(separatedBy: "\n\n")
            .filter { text in
                text.contains(MarkdownType.commentStart.syntax) == false && text.contains(MarkdownType.commentEnd.syntax) == false
            }
    }
    
    private func convert(_ string: String, to newString: String, paragraph: [String]) -> [String] {
        paragraph.map { text in
            if !text.hasPrefix(MarkdownType.code.syntax) && !text.hasPrefix(MarkdownType.list.syntax) {
                return text.replacingOccurrences(of: string, with: newString)
            }
            return text
        }
    }
    
    private func parse(_ rawParagraph: [String]) -> Chapter {
        var chapter: Chapter = Chapter(title: "", overview: DataManager.defaultSection, sections: [])
        var sections: [Section] = []
        var section: Section = DataManager.defaultSection
        var sectionIndex = 0
        
        for paragraph in rawParagraph {
            if paragraph.hasPrefix(MarkdownType.heading1.syntax) {
                chapter.title = paragraph.trimmingCharacters(in: CharacterSet(charactersIn: MarkdownType.heading1.syntax))
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
                section.title = paragraph.trimmingCharacters(in: CharacterSet(charactersIn: MarkdownType.heading2.syntax))
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
