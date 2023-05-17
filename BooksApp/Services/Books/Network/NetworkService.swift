//
//  NetworkService.swift
//  BooksApp
//
//  Created by Alsu Faizova on 07.05.2023.
//

import Foundation
import Alamofire

protocol INetworkService: AnyObject {
    func getPopularBooks(completion: @escaping ([Book]) -> Void)
    func getNewBooks(completion: @escaping ([Book]) -> Void)
    func getCategoryBooks(category: String, completion: @escaping ([Book]) -> Void)
}

final class NetworkService: INetworkService {

    private let apiBase = "https://www.googleapis.com/books/v1/volumes"
    
    func getPopularBooks(completion: @escaping ([Book]) -> Void) {
        let request = AF.request(apiBase + "?q=intitle")

        request.responseDecodable(of: APIResponse<[Book]>.self) { dataResponse in
            let response: APIResponse<[Book]>? = dataResponse.value
            
            completion(response?.items ?? [])
        }
    }
    
    func getNewBooks(completion: @escaping ([Book]) -> Void) {
        let params: [String: Any] = ["orderBy=": "newest"]
        let request = AF.request(apiBase + "?q=be", parameters: params)

        request.responseDecodable(of: APIResponse<[Book]>.self) { dataResponse in
            let response: APIResponse<[Book]>? = dataResponse.value

            completion(response?.items ?? [])
        }
    }
    
    func getCategoryBooks(category: String, completion: @escaping ([Book]) -> Void) {
        let params: [String: Any] = ["orderBy=": "newest"]
        let request = AF.request(apiBase + "?q=\(category)", parameters: params)
        
        request.responseDecodable(of: APIResponse<[Book]>.self) { dataResponse in
            let response: APIResponse<[Book]>? = dataResponse.value
            
            completion(response?.items ?? [])
        }
    }
}
