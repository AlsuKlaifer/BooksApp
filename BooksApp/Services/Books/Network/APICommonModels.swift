//
//  APICommonModels.swift
//  BooksApp
//
//  Created by Alsu Faizova on 07.05.2023.
//

import Foundation

struct APIResponse<ContentModel: Decodable>: Decodable {
    let kind: String
    let totalItems: Int
    let items: ContentModel
}
