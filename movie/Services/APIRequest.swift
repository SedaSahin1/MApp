//
//  APIRequest.swift
//  movie
//
//  Created by Seda Şahin on 3.03.2024.
//

import Foundation
import Alamofire

class MovieService {
    
    static let shared = MovieService()
    let cache = NSCache<NSString, NSData>()
  
    func getMovies<T: Decodable>(url: String, method: HTTPMethod, parameters: [String: Any], responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let newUrl = url
        if NetworkReachabilityManager()?.isReachable ?? false {
            fetchDataFromServer(url: newUrl, method: method, parameters: parameters, responseType: responseType, completion: completion)
        } else {
            if let cachedData = cache.object(forKey: newUrl as NSString) as NSData? {
                handleSuccessResponse(data: cachedData as Data, responseType: responseType, completion: completion)
            } else {
                if let loadedData = CacheManager.loadDataFromCache(fileName: "\(getLastTwoComponents(from: url) ?? "")\(parameters["page"] ?? 0).txt") {
                    print("Loaded data: \(loadedData)")
                    handleSuccessResponse(data: loadedData as Data, responseType: responseType, completion: completion)
                }
                let error = NSError(domain: "NoInternetErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "No internet connection"])
                completion(.failure(error))
            }
        }
    }

    private func fetchDataFromServer<T: Decodable>(url: String, method: HTTPMethod, parameters: [String: Any], responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    self.handleSuccessResponse(data: data, responseType: responseType, completion: completion)
                    self.cache.setObject(data as NSData, forKey: url as NSString)
                    CacheManager.saveDataToCache(data: data, fileName: "\(getLastTwoComponents(from: url) ?? "")\(parameters["page"] ?? 0).txt")
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    private func handleSuccessResponse<T: Decodable>(data: Data, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let jsonData = try JSONDecoder().decode(T.self, from: data)
            completion(.success(jsonData))
        } catch {
            completion(.failure(error))
        }
    }
}

func getLastTwoComponents(from urlString: String) -> String? {
    if let url = URL(string: urlString) {
        let pathComponents = url.pathComponents
            if pathComponents.count >= 2 {
            let lastComponent = pathComponents[pathComponents.count - 1]
            let secondToLastComponent = pathComponents[pathComponents.count - 2]
            return "\(secondToLastComponent)\(lastComponent)"
        }
    }
    return nil
}
