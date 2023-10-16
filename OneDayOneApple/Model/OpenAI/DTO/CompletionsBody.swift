//
//  CompletionsBody.swift
//  OneDayOneApple
//
//  Created by Dasan on 2023/10/13.
//

import Foundation

struct CompletionsBody: Encodable {
    let model: String
    let prompt: String
    let max_tokens: Int
    let temperature: Float?
    
    init(
        model: String = "gpt-3.5-turbo-instruct",
        prompt: String,
        max_tokens: Int = 200,
        temperature: Float? = 1.0
    ){
        self.model = model
        self.prompt = prompt
        self.max_tokens = max_tokens
        self.temperature = temperature
    }
}
