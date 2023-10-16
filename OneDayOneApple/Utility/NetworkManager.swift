//
//  NetworkManager.swift
//  OneDayOneApple
//
//  Created by Dasan on 2023/10/14.
//

import Foundation

enum NetworkError: LocalizedError {
    case requestFailed
    case invalidResponse
    case noData
    
    var errorDescription: String? {
        switch self {
        case .requestFailed:
            return "요청이 실패하였습니다."
        case .invalidResponse:
            return "유효하지 않은 응답이거나 성공적인 응답이 아닙니다."
        case .noData:
            return "데이터가 없습니다."
        }
    }
}

final class NetworkManager {
    func fetchData(urlRequest: URLRequest?, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let urlRequest = urlRequest else { return }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completion(.failure(NetworkError.requestFailed))
                
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
