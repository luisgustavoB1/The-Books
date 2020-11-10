//
//  TheBooksTests.swift
//  TheBooksTests
//
//  Created by Luis Gustavo Oliveira Silva on 09/11/20.
//

import XCTest
import SnapshotTesting
@testable import The_Books

class BookDescriptionTests: XCTestCase {
    
    static var book = Book(
        artworkUrl100: "https://is2-ssl.mzstatic.com/image/thumb/Publication124/v4/fd/45/3c/fd453c93-1696-c674-3743-894a94110a79/source/100x100bb.jpg",
        artistName: "Apple Inc.",
        trackViewUrl: "https://books.apple.com/us/artist/apple-inc/405307759?uo=4",
        trackName: "The Swift Programming Language (Swift 5.3)",
        formattedPrice: "Free",
        description: "Swift is a programming language for creating iOS, macOS, watchOS, and tvOS apps. Swift builds on the best of C and Objective-C, without the constraints of C compatibility. Swift adopts safe programming patterns and adds modern features to make programming easier, more flexible, and more fun. Swift’s clean slate, backed by the mature and much-loved Cocoa and Cocoa Touch frameworks, is an opportunity to reimagine how software development works.<br /><br />\nThis book provides:<br />\n- A tour of the language.<br />\n- A detailed guide delving into each language feature.<br />\n- A formal reference for the language.",
        kind: "ebook",
        averageUserRating: 4
    )
    
    var bookDescriptionViewModel = BookDescriptionViewModel(book: book)

    func testStarEvaluation() {
        //Given
        let text: String
        guard let note = BookDescriptionTests.book.averageUserRating else { return }
        
        //When
        text = bookDescriptionViewModel.starEvaluation(note: Int(note))
        
        //Then
        assertSnapshot(matching: text, as: .dump)
    }
    
    func testAttributedString() {
        // Given
        let title = "Name:"
        let value = BookDescriptionTests.book.trackName
        let label = UILabel()
        
        //Whem
        label.attributedText = bookDescriptionViewModel.attributedString(title: title, valueText: value, titleFontSize: 25, valueTextFontSize: 20)
        
        //Then
        assertSnapshot(matching: label, as: .image())
    }

}
