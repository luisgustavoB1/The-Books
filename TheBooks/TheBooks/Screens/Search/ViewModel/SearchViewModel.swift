//
//  SearchViewModel.swift
//  The Books
//
//  Created by Luis Gustavo Oliveira Silva on 06/11/20.
//

import Foundation
import UIKit

protocol SearchViewModelDelegate: AnyObject {
    func reloadData()
}

class SearchViewModel {
    
    var service: SearchProtocol
    var listBook = [Book]()
    var filteredList = [Book]()
    var recentSurveyed = [String]()
    var listRecentSurvevedName = [String]()
    var verificationName: String = ""
    weak var delegate: SearchViewModelDelegate?
    var tableViewType = TableViewType.searchResult
    
    init(service: SearchProtocol = SearchService()) {
        self.service = service
    }
    
    func numberOfItems() -> Int {
        switch tableViewType {
        case .searchResult:
            return filteredList.count
            
        case .recentSurveyed:
            return recentSurveyed.count
        }
    }
    
    public func setBookName(at row: Int) -> String {
        return filteredList[row].trackName
    }
    
    public func setBookArtist(at row: Int) -> String {
        filteredList[row].artistName
    }
    
    public func setBookImage(at row: Int) -> String {
        filteredList[row].artworkUrl100
    }
    
    public func setRecentSurveyedName(at row: Int) -> String {
        recentSurveyed[row]
    }
    
    func fetchBookList(completion : @escaping (SearchRequestState) -> Void) {
        service.fetchSearchBook(url: Constants.endpointSearch) { result in
            switch result {
            case .success( let listBook):
                self.listBook = listBook
                completion(.success)
            case .failure:
                completion(.failure)
            }
        }
    }
    
    public func searchFilter(name: String) -> Int {
        recentSurveyed(name: name)
        if verificationName != name {
            clearList()
            _ = listBook.map {
                if $0.trackName == name {
                    filteredList.append($0)
                }
            }
        }
        delegate?.reloadData()
        return filteredList.count
    }
    
    public func clearList() {
        filteredList.removeAll()
        delegate?.reloadData()
    }
    
    public func recentSurveyed(name: String) {
        let filtered = listRecentSurvevedName.filter { $0 == name }
        if filtered.count > 0 {
            guard let index = listRecentSurvevedName.firstIndex(of: name) else { return }
            listRecentSurvevedName.remove(at: index)
        }
        listRecentSurvevedName.append(name)
        recentSurveyed.removeAll()
        recentSurveyed.append("Recent surveyed:")
        for name in listRecentSurvevedName.reversed() {
            recentSurveyed.append(name)
        }
        delegate?.reloadData()
    }
    
    public func fullList() {
        filteredList.append(contentsOf: listBook)
        delegate?.reloadData()
    }
    
    public func attributedString(text: String, index: Int) -> NSAttributedString {
        if index == 0 {
            let text = NSMutableAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .bold)])
            return text
        } else {
            let text = NSMutableAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .regular)])
            return text
        }
    }
    
    public enum TableViewType {
         case searchResult
         case recentSurveyed
     }
    
    public enum SearchRequestState {
         case success
         case failure
    }
}
