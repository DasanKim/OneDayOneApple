//
//  CompletionsResponse.swift
//  OneDayOneApple
//
//  Created by Dasan on 2023/10/13.
//

import Foundation

struct CompletionsResponse: Decodable {
    let id: String
    let choices: [CompletionsChoices]
    let usage: CompletionsUsage
}

struct CompletionsChoices: Decodable {
    let text: String
}

struct CompletionsUsage: Decodable {
    let promptTokens: Int
    let completionTokens: Int
    let totalTokens: Int
    
    private enum CodingKeys: String, CodingKey {
        case promptTokens = "prompt_tokens"
        case completionTokens = "completion_tokens"
        case totalTokens = "total_tokens"
    }
}
