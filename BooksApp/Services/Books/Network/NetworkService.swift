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
        let request = AF.request(apiBase + "?q=+subject:life&orderBy=newest")
        print(request)
        request.responseDecodable(of: APIResponse<[Book]>.self) { dataResponse in
            let response: APIResponse<[Book]>? = dataResponse.value
            print(dataResponse)
            completion(response?.items ?? [])
        }
    }
    
    func getNewBooks(completion: @escaping ([Book]) -> Void) {
        let params: [String: Any] = ["orderBy=": "newest"]
        let request = AF.request(apiBase + "?q=inauthor:Thomas&intitle:the", parameters: params)

        request.responseDecodable(of: APIResponse<[Book]>.self) { dataResponse in
            let response: APIResponse<[Book]>? = dataResponse.value
            completion(response?.items ?? [])
        }
    }
    
    func getCategoryBooks(category: String, completion: @escaping ([Book]) -> Void) {
        var newCategory = ""
        switch category {
        case "Popular":
            newCategory = "+subject:life&orderBy=newest"
        case "IT":
            newCategory = "+subject:computer"
        case "Fantastic":
            newCategory = "+subject:fiction"
        case "Psychology":
            newCategory = "+subject:psychology"
        case "Classic":
            newCategory = "+subject:literature"
        default:
            newCategory = "intitle"
        }
        
        let request = AF.request(apiBase + "?q=\(newCategory)")
        request.responseDecodable(of: APIResponse<[Book]>.self) { dataResponse in
            let response: APIResponse<[Book]>? = dataResponse.value
            completion(response?.items ?? [])
        }
    }
}
