//
//  String+Extension.swift
//  BooksApp
//
//  Created by Alsu Faizova on 06.06.2023.
//

import Foundation

extension String {

    var localized: String {
        NSLocalizedString(
            self,
            comment: "\(self) could not be found in Localizable.strings"
        )
    }
}
