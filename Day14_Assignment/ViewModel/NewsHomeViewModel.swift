//
//  NewsHomeViewModel.swift
//  Day14_Assignment
//
//  Created by Rayaheen Mseri on 23/09/1446 AH.
//

import SwiftUI
import Alamofire

extension HomeView{
    
    class NewsHomeViewModel: ObservableObject{
        
        @Published var news: [News] = []
        @Published var isLoading: Bool = false
        @Published var erorrMessage: String?
        @Published var showErrorAlert: Bool = false
        @Published var currentPage: Int = 1
        @Published var totalPages = 0
        //var totalResults = 109
        var pageSize = 10
        private var isRequesting = false
        private let interceptor = NetworkInterceptor()
        private let baseURL = "https://newsapi.org/v2/everything?domains=wsj.com&sortBy=publishedAt"
        
        
        func loadNews() {
            // Prevents making multiple simultaneous requests
            guard !isRequesting else { return }
            isRequesting = true

            // Define query parameters for pagination
            let parameters: [String: Any] = [
                "page": currentPage,
                "pageSize": pageSize
            ]

            // Indicate loading state
            isLoading = true

            // Retrieve the API key from the keychain using APIKeyManager
            let apiKey = APIKeyManager.shared.getAPIKey()
            print("Using api keychain : \(apiKey)")

            // Build the URL for the request, including the API key
            let url = "\(baseURL)&apiKey=\(apiKey)"

            // Make the network request using Alamofire
            AF.request(url, parameters: parameters, interceptor: interceptor)
                .validate()  // Ensures the request is successful (HTTP status 200)
                .responseDecodable(of: NewsResponse.self) { response in
                    // Hide loading indicator on completion
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }

                    switch response.result {
                    case .success(let newsResponse):
                        // On successful response, append the fetched news articles to the list
                        DispatchQueue.main.async {
                            self.news.append(contentsOf: newsResponse.articles)
                            self.currentPage += 1
                            self.totalPages = (newsResponse.totalResults ?? 1) / self.pageSize
                            self.erorrMessage = nil
                        }
                    case .failure(let error):
                        // On failure, set error message and trigger alert
                        DispatchQueue.main.async {
                            self.erorrMessage = "Error: \(error.localizedDescription)"
                            self.showErrorAlert = true
                        }
                    }
                    self.isRequesting = false  // Reset the requesting flag
                }
        }
    }
}
