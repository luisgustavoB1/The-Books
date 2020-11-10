//
//  SearchViewModel.swift
//  TheBooksTests
//
//  Created by Luis Gustavo Oliveira Silva on 09/11/20.
//

import XCTest
import SnapshotTesting
@testable import The_Books

class SearchViewModelTests: XCTestCase {

    var searchViewModel: SearchViewModel = SearchViewModel()
    
    static var book = Book(
        artworkUrl100: "https://is2-ssl.mzstatic.com/image/thumb/Publication124/v4/fd/45/3c/fd453c93-1696-c674-3743-894a94110a79/source/100x100bb.jpg",
        artistName: "Apple Inc.",
        trackViewUrl: "https://books.apple.com/us/artist/apple-inc/405307759?uo=4",
        trackName: "Swift",
        formattedPrice: "Free",
        description: "Swift is a programming language for creating iOS, macOS, watchOS, and tvOS apps. Swift builds on the best of C and Objective-C, without the constraints of C compatibility. Swift adopts safe programming patterns and adds modern features to make programming easier, more flexible, and more fun. Swift’s clean slate, backed by the mature and much-loved Cocoa and Cocoa Touch frameworks, is an opportunity to reimagine how software development works.<br /><br />\nThis book provides:<br />\n- A tour of the language.<br />\n- A detailed guide delving into each language feature.<br />\n- A formal reference for the language.",
        kind: "ebook",
        averageUserRating: 4
    )
    
    func testAttributedStringwithIndex0() {
        // Given
        let index: Int = 0
        let text = "Test"
        let label = UILabel()
        
        //Whem
        label.attributedText = searchViewModel.attributedString(text: text, index: index)
        
        //Then
        assertSnapshot(matching: label, as: .image())
    }
    
    func testAttributedStringwithIndex1() {
        // Given
        let index: Int = 1
        let text = "Test"
        let label = UILabel()
        
        //Whem
        label.attributedText = searchViewModel.attributedString(text: text, index: index)
        
        //Then
        assertSnapshot(matching: label, as: .image())
    }
    
    func testClearList() {
        // Given
        searchViewModel.filteredList.append(SearchViewModelTests.book)
        
        //Whem
        searchViewModel.clearList()
        
        //Then
        XCTAssertEqual(searchViewModel.filteredList.count, 0)
    }
    
    func testSearchFilter() {
        // Given
        let name = "Swift"
        searchViewModel.listBook.append(SearchViewModelTests.book)
        
        //Whem
        _ = searchViewModel.searchFilter(name: name)
        
        //Then
        XCTAssertEqual(searchViewModel.filteredList[0].trackName, name)
    }
    
    func testFullList() {
        // Given
        searchViewModel.listBook.append(SearchViewModelTests.book)
        
        //Whem
        searchViewModel.fullList()
        
        //Then
        XCTAssertEqual(searchViewModel.filteredList.count, 1)
    }
    
    func testSetBookName() {
        // Given
        searchViewModel.filteredList.append(SearchViewModelTests.book)
        let filteredListName = searchViewModel.filteredList[0].trackName
        
        //Whem
        let name = searchViewModel.setBookName(at: 0)
        
        //Then
        XCTAssertEqual(name, filteredListName)
    }
    
    func testSetBookArtist() {
        // Given
        searchViewModel.filteredList.append(SearchViewModelTests.book)
        let filteredListArtist = searchViewModel.filteredList[0].artistName
        
        //Whem
        let artist = searchViewModel.setBookArtist(at: 0)
        
        //Then
        XCTAssertEqual(artist, filteredListArtist)
    }
    
    func testSetBookImage() {
        // Given
        searchViewModel.filteredList.append(SearchViewModelTests.book)
        let filteredListImage = searchViewModel.filteredList[0].artworkUrl100
        
        //Whem
        let image = searchViewModel.setBookImage(at: 0)
        
        //Then
        XCTAssertEqual(image, filteredListImage)
    }
    
    func testSetRecentSurveyedName() {
        // Given
        let recentSurveyedName = "Swift"
        searchViewModel.recentSurveyed.append(recentSurveyedName)
        
        //Whem
        let name = searchViewModel.setRecentSurveyedName(at: 0)
        
        //Then
        XCTAssertEqual(name, recentSurveyedName)
    }
    
    func testSetRecentSurveyedNameRepeated() {
        // Given
        let name = "Swift"
        searchViewModel.listRecentSurvevedName.append(name)
        
        //Whem
        searchViewModel.recentSurveyed(name: name)
        
        //Then
        XCTAssertEqual(searchViewModel.listRecentSurvevedName.count, 1)
    }
    
    func testFetchBookList() throws {
        
        let viewModel = SearchViewModel(service: SearchServiceStub())
        
        let exp = expectation(description: "Loading")

        viewModel.fetchBookList { state in
            guard case .success = state else {
                XCTFail("Error fetch")
                return
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3)
        
        XCTAssertEqual(viewModel.listBook.count, 1)
    }
}

class SearchServiceStub: SearchProtocol {
    func fetchSearchBook(url: String, completion: @escaping (ResultSearch) -> Void) {
        completion(.success(books: [SearchViewModelTests.book]))
    }
}
