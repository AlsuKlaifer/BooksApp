//
//  FirestoreManager.swift
//  BooksApp
//
//  Created by Alsu Faizova on 30.05.2023.
//

import UIKit
import FirebaseDatabase
import FirebaseFirestore

protocol FirestoreManagerProtocol {
    func getUser(collection: String, document: String, completion: @escaping (User?) -> Void)
    func writeUser(collection: String, document: String, name: String, email: String)
}

final class FirestoreManager: FirestoreManagerProtocol {

    private func configureDB() -> Firestore {
        var database: Firestore
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        database = Firestore.firestore()
        return database
    }

    func getUser(collection: String, document: String, completion: @escaping (User?) -> Void) {
        let database = configureDB()
        database.collection(collection).document(document).getDocument { document, error in
            guard error == nil else { completion(nil); return }
            let doc = User(
                name: document?.get("name") as? String ?? "",
                email: document?.get("email") as? String ?? ""
            )
            completion(doc)
        }
    }

    func writeUser(collection: String, document: String, name: String, email: String) {
        let database = configureDB()
        database.collection(collection).document(document).setData([
            "name": "\(name)",
            "email": "\(email)"
        ]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
