//
//  HTTPClient.swift
//  NBKAssessment
//
//  Created by Nouraiz Taimour on 09/08/2023.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}

extension HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async -> Result<T, RequestError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        var queryItems: [URLQueryItem] = []
        if let queryParams = endpoint.queryParams {
            queryParams.forEach { (key, value) in
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            
            urlComponents.queryItems = queryItems
        }
        
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        print(request.url)
        print(request)

        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    print(NSString(data: data, encoding: String.Encoding.utf8.rawValue))
                    return .failure(.decode)
                }
                return .success(decodedResponse)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}

