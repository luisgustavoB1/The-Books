//
//  SearchModel.swift
//  The Books
//
//  Created by Luis Gustavo Oliveira Silva on 06/11/20.
//

import Foundation

struct Results: Decodable {
    var results: [Book]
}

struct Book: Decodable {
    var artworkUrl100: String
    var artistName: String
    var trackViewUrl: String
    var trackName: String
    var formattedPrice: String
    var description: String
    var kind: String
    var averageUserRating: Float?
}
