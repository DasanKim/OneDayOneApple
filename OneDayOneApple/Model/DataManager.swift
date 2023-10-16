//
//  DataManager.swift
//  OneDayOneApple
//
//  Created by Dasan on 2023/10/16.
//

import Foundation

final class DataManager {
    static var chapters: [Chapter] = [
        Chapter(title: "The Basics",
                sections: [
                    Section(title: "Constants and Variables", isComplete: false),
                    Section(title: "Comments", isComplete: false),
                    Section(title: "Semicolons", isComplete: false),
                    Section(title: "Integers", isComplete: false),
                    Section(title: "Floating-Point Numbers", isComplete: false),
                    Section(title: "Type Safety and Type Inference", isComplete: false),
                    Section(title: "Numeric Literals", isComplete: false),
                    Section(title: "Numeric Type Conversion", isComplete: false),
                    Section(title: "Type Aliases", isComplete: false),
                    Section(title: "Booleans", isComplete: false),
                    Section(title: "Tuples", isComplete: false),
                    Section(title: "Optionals", isComplete: false),
                    Section(title: "Error Handling", isComplete: false),
                    Section(title: "Assertions and Preconditions", isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Basic Operators",
                sections: [
                    Section(title: "Terminology", isComplete: true),
                ],
                isComplete: true),
        Chapter(title: "Strings and Characters",
                sections: [
                    Section(title: "String Literals", isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Collection Types",
                sections: [
                    Section(title: "Mutability of Collections", isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Control Flow",
                sections: [
                    Section(title: "For-In Loops", isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Functions",
                sections: [
                    Section(title: "Defining and Calling Functions", isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Closures",
                sections: [
                    Section(title: "Closure Expressions", isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Enumerations",
                sections: [
                    Section(title: "Enumeration Syntax", isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Structures and Classes",
                sections: [
                    Section(title: "Comparing Structures and Classes", isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Properties",
                sections: [
                    Section(title: "Stored Properties", isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Methods",
                sections: [
                    Section(title: "Instance Methods", isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Subscripts",
                sections: [
                    Section(title: "Subscripts Syntax", isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Inheritance",
                sections: [
                    Section(title: "Defining a Base Class", isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Initialization",
                sections: [
                    Section(title: "Setting Initial Values for Stored Properties", isComplete: false),
                ],
                isComplete: false),
        
        Chapter(title: "Deinitialization",
                sections: [
                    Section(title: "How Deinitialization Works", isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Optional Chaining",
                sections: [
                    Section(title: "Optional Chaining as an Alternative to Forced Unwrapping", isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Error Handling",
                sections: [
                    Section(title: "Representing and Throwing Errors", isComplete: false),
                ],
                isComplete: false),
        Chapter(title: "Concurrency",
                sections: [
                    Section(title: "Defining and Calling Asynchronous Functions", isComplete: false),
                ],
                isComplete: false),
    ]
}
