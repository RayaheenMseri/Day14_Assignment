//
//  NetworkInterceptor.swift
//  Day14_Assignment
//
//  Created by Rayaheen Mseri on 23/09/1446 AH.
//
//
import Alamofire
import Foundation

// Custom interceptor to modify and retry network requests
final class NetworkInterceptor: RequestInterceptor {
    
    // API key for authentication
    private var apiKey: String {
        return "42bcbf162bb04adba36eaf161e0013be" // Ideally, fetch from SecureStorage instead of hardcoding
    }

    // Modify requests to include the API key in the Authorization header
    func adapt(_ urlRequest: URLRequest, for session: Alamofire.Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var modifiedRequest = urlRequest
        modifiedRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization") // Attach API key
        completion(.success(modifiedRequest)) // Return the modified request
    }

    // Retry failed requests if the response status code is 401 (Unauthorized)
    func retry(_ request: Request, for session: Alamofire.Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            completion(.doNotRetry) // Do not retry if it's not a 401 error
            return
        }

        completion(.retryWithDelay(1.0)) // Retry the request after a 1-second delay
    }
}
