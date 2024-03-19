//
//  File.swift
//  
//
//  Created by Emre Tanrısever on 4.02.2024.
//

import Foundation

final class BaseAPI {
    
    private init() {  }
    private let urlSession = URLSession.shared
    private let jsonDecoder = JSONDecoder()
    
    public static let shared = BaseAPI()
    
    func request<T: Codable>(with endPoint: EndPointProtocol, completion: @escaping((Result<T, NetworkError>) -> Void)) {
        urlSession.dataTask(with: endPoint.createURLRequest()) { data, response, error in
            
            if error != nil {
                completion(.failure(.unExpectedError))
            }
            
            if let statusCode = response as? HTTPURLResponse {
                switch statusCode.statusCode {
                case 200...299:
                    if let data = data {
                        guard let decodedData = self.decodeData(type: T.self, with: data) else {
                            completion(.failure(.decodeError))
                            return
                        }
                        completion(.success(decodedData))
                    } else {
                        completion(.failure(.noData))
                    }
                case 400:
                    completion(.failure(.badRequest))
                case 401:
                    completion(.failure(.unAuthorized))
                case 429:
                    completion(.failure(.tooManyRequest))
                case 500:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.unknownError))
                }
            }
            
        }.resume()
    }
    
    private func decodeData<T: Codable>(type: T.Type, with data: Data) -> T? {
        do {
            return try jsonDecoder.decode(type, from: data)
        } catch {
            return nil
        }
    }
}
