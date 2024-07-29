//
//  String+Extensions.swift
//  MoviesApp
//
//  Created by Sajed Shaikh on 29/07/24.
//

import Foundation

extension String {
    var urlEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
