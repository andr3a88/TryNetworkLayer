//
//  NetworkDispatcher.swift
//  TryNetworkLayer
//
//  Created by Andrea on 30/12/2019.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import Alamofire
import Foundation

public enum NetworkError: Error {
    case badInput
    case noData
    case forbidden
    case notAuthorized
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badInput:
            return NSLocalizedString("Bad input", comment: "")
        case .noData:
            return NSLocalizedString("No data", comment: "")
        case .forbidden:
            return NSLocalizedString("Forbiddden", comment: "")
        case .notAuthorized:
            return NSLocalizedString("Not authorized", comment: "")
        }
    }
}

public class NetworkDispatcher: Dispatcher {
    
    private var environment: Environment
    private var sessionManager: Session
    
    required public init(environment: Environment) {
        self.environment = environment
        
        let configuration = URLSessionConfiguration.default
        
        // Set timeout interval.
        configuration.timeoutIntervalForRequest = 30.0
        configuration.timeoutIntervalForResource = 30.0
        
        // Set cookie policies.
        configuration.httpCookieAcceptPolicy = HTTPCookie.AcceptPolicy.always
        configuration.httpCookieStorage = HTTPCookieStorage.shared
        configuration.httpShouldSetCookies = false
        
        self.sessionManager = Alamofire.Session(configuration: configuration)
    }
    
    public func execute(request: Request, completion: @escaping (_ response: Response) -> Void) throws {
        let req = try self.prepareURLRequest(for: request)
        self.sessionManager.request(req)
            .validate()
            .responseJSON { response in
                completion(Response(response, for: request))
        }
    }
    
    private func prepareURLRequest(for request: Request) throws -> URLRequest {
        // Compose the url
        let fullUrl = "\(environment.host)/\(request.path)"
        var urlRequest = URLRequest(url: URL(string: fullUrl)!)
        
        // Working with parameters
        if let parameters = request.parameters {
            switch parameters {
            case .body(let params):
                // Parameters are part of the body
                if let params = params as? [String: String] {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: .init(rawValue: 0))
                } else {
                    throw NetworkError.badInput
                }
            case .url(let params):
                // Parameters are part of the url
                let queryParams = self.getQueryParams(params: params)
                guard var components = URLComponents(string: fullUrl) else {
                    throw NetworkError.badInput
                }
                components.queryItems = queryParams
                urlRequest.url = components.url
            }
        }
        
        // Add headers from environment and request
        environment.headers.forEach { urlRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
        request.headers?.forEach { urlRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
        
        // Setup HTTP method
        urlRequest.httpMethod = request.method.rawValue
        
        return urlRequest
    }

    private func getQueryParams(params: [String: Any?]) -> [URLQueryItem] {
        let paramsFiltered = params.filter({ (arg) -> Bool in
            let (_, value) = arg
            return value != nil ? true : false
        })
        var queryItems: [URLQueryItem] = []
        paramsFiltered.forEach({ (key: String, value: Any?) in
            if let array = value as? [String] {
                for paramValue in array {
                    queryItems.append(URLQueryItem(name: key, value: paramValue))
                }
            } else if let value = value as? String {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
        })
        return queryItems
    }
}
