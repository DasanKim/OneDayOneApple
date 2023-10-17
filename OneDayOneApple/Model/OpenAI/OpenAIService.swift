//
//  OpenAIService.swift
//  OneDayOneApple
//
//  Created by Dasan on 2023/10/14.
//

import Foundation

final class OpenAIService {
    private let networkManager = NetworkManager()
    private let baseURL: String
    private let endpoint: String
    
    init(baseURL: String, endpoint: String) {
        self.baseURL = baseURL
        self.endpoint = endpoint
    }
    
    func sendMessage(message: String, completion: @escaping (Result<CompletionsResponse, Error>) -> Void) {
        let body = CompletionsBody(prompt: message + Constants.commendTranslateToKorean)
        let urlRequest = configureRequest(body: body)
        
        networkManager.fetchData(urlRequest: urlRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(CompletionsResponse.self, from: data)
                    completion(.success(response))
                } catch(let error) {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension OpenAIService {
    private func configureRequest(body: CompletionsBody) -> URLRequest? {
        guard let url = URL(string: baseURL + endpoint) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("Bearer \(Constants.OpenAI_API_KEY)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(body) {
            urlRequest.httpBody = encoded
        }
    
        return urlRequest
    }
}
