//
//  NetworkService.swift
//  BooksApp
//
//  Created by Alsu Faizova on 07.05.2023.
//

import Foundation
import Alamofire

protocol INetworkService: AnyObject {
    func getNewBooks(completion: @escaping ([Book]) -> Void)
}

final class NetworkService: INetworkService {

    private let apiBase = "https://www.googleapis.com/books/v1/volumes"

    func getNewBooks(completion: @escaping ([Book]) -> Void) {
        // let params: [String: Any] = ["page": page] // здесь можно задавать любые query string параметры
        let request = AF.request(apiBase + "?q=intitle") // parameters: params)

        print(request)
        request.responseDecodable(of: APIResponse<[Book]>.self) { dataResponse in
            let response: APIResponse<[Book]>? = dataResponse.value
            
//            print("response", response?.items[0])
            
            completion(response?.items ?? [])
        }
    }
}
