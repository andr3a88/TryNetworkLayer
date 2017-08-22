//
//  NetworkDispatcher.swift
//  TryNetworkLayer
//
//  Created by Andrea on 21/08/2017.
//  Copyright © 2017 Ennova Research Srl. All rights reserved.
//

import Foundation
import Alamofire

public enum NetworkErrors: Error {
    case badInput
    case noData
}

public class NetworkDispatcher: Dispatcher {
    
    private var environment: Environment
    private var session: SessionManager
    
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
        
        self.session = Alamofire.SessionManager(configuration: configuration)
    }
    
    public func execute(request: Request, completion: @escaping (_ response: Response) -> Void) throws {
        let rq = try self.prepareURLRequest(for: request)
        self.session.request(rq)
            .validate()
            .responseJSON { response in
                completion(Response(response, for: request))
        }
    }
    
    private func prepareURLRequest(for request: Request) throws -> URLRequest {
        // Compose the url
        let full_url = "\(environment.host)/\(request.path)"
        var url_request = URLRequest(url: URL(string: full_url)!)
        
        // Working with parameters
        if let parameters = request.parameters {
            switch parameters {
            case .body(let params):
                // Parameters are part of the body
                if let params = params as? [String: String] { // just to simplify
                    url_request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .init(rawValue: 0))
                } else {
                    throw NetworkErrors.badInput
                }
            case .url(let params):
                // Parameters are part of the url
                if let params = params as? [String: String] { // just to simplify
                    let query_params = params.map({ (element) -> URLQueryItem in
                        return URLQueryItem(name: element.key, value: element.value)
                    })
                    guard var components = URLComponents(string: full_url) else {
                        throw NetworkErrors.badInput
                    }
                    components.queryItems = query_params
                    url_request.url = components.url
                } else {
                    throw NetworkErrors.badInput
                }
            }
        }
        
        // Add headers from enviornment and request
        environment.headers.forEach { url_request.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
        request.headers?.forEach { url_request.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
        
        // Setup HTTP method
        url_request.httpMethod = request.method.rawValue
        
        return url_request
    }
}
