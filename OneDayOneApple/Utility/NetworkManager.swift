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

/// 1. 요 아이는 struct여도 될 거 같이 생겼는데 class여서
/// class와 struct의 차이부터 시작해서
/// 선정 기준이나 메모리에서 어떻게 동작하는지까지 물어볼거 같아요
/// 
/// 2. fetchData를 조금 더 고도화 할 수 있을거 같아요
/// Alamofire를 보면서 network interceptor 개념이나,
/// decoding, errorhandling 등을 분리해보는것도 좋은 경험일 것 같습니다.
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
