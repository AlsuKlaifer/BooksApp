//
//  Coordinator.swift
//  BooksApp
//
//  Created by Alsu Faizova on 12.04.2023.
//

import UIKit

typealias CoordinatorHandler = () -> ()

protocol Coordinator: AnyObject {
    
    var navigationController: UINavigationController { get set }
//    var flowCompletionHander: CoordinatorHandler? { get set }
                                                        
    func start()
}
