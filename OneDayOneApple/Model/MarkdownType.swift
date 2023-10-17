//
//  MarkdownType.swift
//  OneDayOneApple
//
//  Created by Dasan on 2023/10/16.
//

enum MarkdownType {
    case heading1
    case heading2
    case heading3
    case heading4
    case code
    case list
    case commentStart
    case commentEnd
    case newLine
    case spacing
    
    var syntax: String {
        switch self {
        case .heading1:
            return "# "
        case .heading2:
            return "## "
        case .heading3:
            return "### "
        case .heading4:
            return "#### "
        case .code:
            return "```"
        case .list:
            return "- "
        case .commentStart:
            return "<!--"
        case .commentEnd:
            return "-->"
        case .newLine:
            return "\n"
        case .spacing:
            return " "
        }
    }
}
