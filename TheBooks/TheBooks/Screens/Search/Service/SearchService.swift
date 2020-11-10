//
//  SearchService.swift
//  The Books
//
//  Created by Luis Gustavo Oliveira Silva on 06/11/20.
//

import Foundation

enum ResultSearch {
    case success(books: [Book])
    case failure(error: Error)
}

enum Error {
    case parseError(error: String)
}

protocol SearchProtocol {
    func fetchSearchBook(url: String, completion: @escaping( _ result: ResultSearch) -> Void)
}

struct SearchService: SearchProtocol {
    func fetchSearchBook(url: String, completion: @escaping( _ result: ResultSearch ) -> Void) {
            var booklist = [Book]()
            guard let url = URL(string: url) else { return }
            URLSession.shared.dataTask(with: url) { data, _, error in
                DispatchQueue.main.async {
                    if error == nil {
                        do {
                            guard let data = data else {
                                return
                            }
                            let list = try JSONDecoder().decode(Results.self, from: data)
                            booklist = list.results
                            completion(ResultSearch.success(books: booklist))
                        } catch {
                            if let data = data {
                                let str = String(data: data, encoding: .utf8)
                                print("Parse Error3", str as Any, error)
                            } else {
                                print("Parse Error3", error)
                            }
                            completion(ResultSearch.failure(error: Error.parseError(error: "Erro no parse")))
                        }
                    }
                }
            }.resume()
        }
}
