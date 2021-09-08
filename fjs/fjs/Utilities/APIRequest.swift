//
//  APIRequest.swift
//  fjs
//
//  Created by Dan Ackerman on 9/6/21.
//

import Foundation

let dataErrorDomain = "dataErrorDomain"

enum DataErrorCode: NSInteger {
    case networkUnavailable = 101
    case wrongDataFormat = 102
    case badEndpoint = 103
    case badResponse = 104
    case requestFailed = 105
}

// Ok before you complain that this is huge and complex.   I got this idea from an online article and there are alot of projects using this service model for rest api requests.

class ApiRequest {
    
    private init() {}
    static let shared = ApiRequest()
    
    private let urlSession = URLSession.shared
    
 
    func get<T: Decodable>(ApiKey: String, targetURL: String, associatedtype model: T.Type, completion: @escaping  (Result<T, Error>) -> Void) {
        
        guard let urlComponents = URLComponents(string: targetURL) else {
            let error = NSError(domain: dataErrorDomain, code: DataErrorCode.badEndpoint.rawValue, userInfo: nil)
            completion(Result.failure(error))
            return
        }
        
        guard let url = urlComponents.url else {
            let error = NSError(domain: dataErrorDomain, code: DataErrorCode.badEndpoint.rawValue, userInfo: nil)
            completion(Result.failure(error))
            return
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        
        if (ApiKey != "") {
            request.setValue(ApiKey, forHTTPHeaderField: "Authorization")
        }
        
        urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(Result.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: dataErrorDomain, code: DataErrorCode.requestFailed.rawValue, userInfo: nil)
                completion(Result.failure(error))
                return
            }
            
            if httpResponse.statusCode == 200 {
                guard let data = data else {
                    let error = NSError(domain: dataErrorDomain, code: DataErrorCode.networkUnavailable.rawValue, userInfo: nil)
                    completion(Result.failure(error))
                    return
                }
                
                do {
                    let response = try! JSONDecoder().decode(model.self, from: data)
                    
                    completion(Result.success(response))
                }
            } else {
                let error = NSError(domain: dataErrorDomain, code: DataErrorCode.badResponse.rawValue, userInfo: nil)
                completion(Result.failure(error))
            }
        }.resume()
    }
    
    func getArray<T: Decodable>(ApiKey: String, targetURL: String, associatedtype model: [T].Type, completion: @escaping  (Result<[T], Error>) -> Void) {
        
        guard let urlComponents = URLComponents(string: targetURL) else {
            let error = NSError(domain: dataErrorDomain, code: DataErrorCode.badEndpoint.rawValue, userInfo: nil)
            completion(Result.failure(error))
            return
        }
        
        guard let url = urlComponents.url else {
            let error = NSError(domain: dataErrorDomain, code: DataErrorCode.badEndpoint.rawValue, userInfo: nil)
            completion(Result.failure(error))
            return
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        request.setValue(ApiKey, forHTTPHeaderField: "Authorization")
        
        urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(Result.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: dataErrorDomain, code: DataErrorCode.requestFailed.rawValue, userInfo: nil)
                completion(Result.failure(error))
                return
            }
            
            if httpResponse.statusCode == 200 {
                guard let data = data else {
                    let error = NSError(domain: dataErrorDomain, code: DataErrorCode.networkUnavailable.rawValue, userInfo: nil)
                    completion(Result.failure(error))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-DD-mm"
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    
                    let response = try! decoder.decode(model.self, from: data)
                    
                    completion(Result.success(response))
                }
            } else {
                let error = NSError(domain: dataErrorDomain, code: DataErrorCode.badResponse.rawValue, userInfo: nil)
                completion(Result.failure(error))
            }
        }.resume()
    }
}
