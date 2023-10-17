//
//  DataManager.swift
//  OneDayOneApple
//
//  Created by Dasan on 2023/10/16.
//

import Foundation
import Markdown
import Markdownosaur

final class DataManager {
    private let markdownParser = MarkdownParser()
    
    func convertAttributedString(from markdownText: String) -> AttributedString {
        let document = Document(parsing: markdownText)
        
        var markdownosaur = Markdownosaur()
        let attributedString = markdownosaur.attributedString(from: document)
        
        return AttributedString(attributedString)
    }
    
    func fetchChapters() -> [Chapter] {
        var chapters = [Chapter]()
        
        guard let theBasics = markdownParser.fetchChapter(fileName: "TheBasics.md"),
              let basicOperators = markdownParser.fetchChapter(fileName: "BasicOperators.md"),
              let stringsAndCharacters = markdownParser.fetchChapter(fileName: "StringsAndCharacters.md"),
              let collectionTypes = markdownParser.fetchChapter(fileName: "CollectionTypes.md"),
              let controlFlow = markdownParser.fetchChapter(fileName: "ControlFlow.md"),
              let functions = markdownParser.fetchChapter(fileName: "Functions.md"),
              let closures = markdownParser.fetchChapter(fileName: "Closures.md"),
              let enumerations = markdownParser.fetchChapter(fileName: "Enumerations.md"),
              let classesAndStructures = markdownParser.fetchChapter(fileName: "ClassesAndStructures.md"),
              let properties = markdownParser.fetchChapter(fileName: "Properties.md"),
              let methods = markdownParser.fetchChapter(fileName: "Methods.md"),
              let subscripts = markdownParser.fetchChapter(fileName: "Subscripts.md")
        else {
            return DataManager.exampleChapters
        }
        
        chapters.append(theBasics)
        chapters.append(basicOperators)
        chapters.append(stringsAndCharacters)
        chapters.append(collectionTypes)
        chapters.append(controlFlow)
        chapters.append(functions)
        chapters.append(closures)
        chapters.append(enumerations)
        chapters.append(classesAndStructures)
        chapters.append(properties)
        chapters.append(methods)
        chapters.append(subscripts)
        
        return chapters
    }
}

// MARK: Example Data
extension DataManager {
    static let defaultSection = Section(title: "", paragraphs: [], isComplete: false)
    
    static var exampleChapters: [Chapter] = [
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
                ]
               ),
        Chapter(title: "Basic Operators",
                overview: defaultSection,
                sections: [
                    Section(title: "Terminology", paragraphs: [], isComplete: false),
                ]
               ),
        Chapter(title: "Strings and Characters",
                overview: defaultSection,
                sections: [
                    Section(title: "String Literals", paragraphs: [], isComplete: false),
                ]
               ),
        Chapter(title: "Collection Types",
                overview: defaultSection,
                sections: [
                    Section(title: "Mutability of Collections", paragraphs: [], isComplete: false),
                ]
               ),
        Chapter(title: "Control Flow",
                overview: defaultSection,
                sections: [
                    Section(title: "For-In Loops", paragraphs: [], isComplete: false),
                ]
               ),
        Chapter(title: "Functions",
                overview: defaultSection,
                sections: [
                    Section(title: "Defining and Calling Functions", paragraphs: [], isComplete: false),
                ]
               ),
        Chapter(title: "Closures",
                overview: defaultSection,
                sections: [
                    Section(title: "Closure Expressions", paragraphs: [], isComplete: false),
                ]
               ),
        Chapter(title: "Enumerations",
                overview: defaultSection,
                sections: [
                    Section(title: "Enumeration Syntax", paragraphs: [], isComplete: false),
                ]
               ),
        Chapter(title: "Structures and Classes",
                overview: defaultSection,
                sections: [
                    Section(title: "Comparing Structures and Classes", paragraphs: [], isComplete: false),
                ]
               ),
        Chapter(title: "Properties",
                overview: defaultSection,
                sections: [
                    Section(title: "Stored Properties", paragraphs: [], isComplete: false),
                ]
               ),
        Chapter(title: "Methods",
                overview: defaultSection,
                sections: [
                    Section(title: "Instance Methods", paragraphs: [], isComplete: false),
                ]
               ),
        Chapter(title: "Subscripts",
                overview: defaultSection,
                sections: [
                    Section(title: "Subscripts Syntax", paragraphs: [], isComplete: false),
                ]
               ),
        Chapter(title: "Inheritance",
                overview: defaultSection,
                sections: [
                    Section(title: "Defining a Base Class", paragraphs: [], isComplete: false),
                ]
               ),
        Chapter(title: "Initialization",
                overview: defaultSection,
                sections: [
                    Section(title: "Setting Initial Values for Stored Properties", paragraphs: [], isComplete: false),
                ]
               ),
        Chapter(title: "Deinitialization",
                overview: defaultSection,
                sections: [
                    Section(title: "How Deinitialization Works", paragraphs: [], isComplete: false),
                ]
               ),
        Chapter(title: "Optional Chaining",
                overview: defaultSection,
                sections: [
                    Section(title: "Optional Chaining as an Alternative to Forced Unwrapping", paragraphs: [], isComplete: false),
                ]
               ),
        Chapter(title: "Error Handling",
                overview: defaultSection,
                sections: [
                    Section(title: "Representing and Throwing Errors", paragraphs: [], isComplete: false),
                ]
               ),
        Chapter(title: "Concurrency",
                overview: defaultSection,
                sections: [
                    Section(title: "Defining and Calling Asynchronous Functions", paragraphs: [], isComplete: false),
                ]
               ),
    ]
}
