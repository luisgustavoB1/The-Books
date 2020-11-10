//
//  BookDescriptionViewModel.swift
//  The Books
//
//  Created by Luis Gustavo Oliveira Silva on 08/11/20.
//

import Foundation
import UIKit

class BookDescriptionViewModel {
    
    private(set)var book: Book
    
    init(book: Book) {
        self.book = book
    }
    
    public func starEvaluation(note: Int) -> String {
        var fullStar = [String]()
        var emptyStar = [String]()
        fullStar = Array(repeating: "★", count: note)
        emptyStar = Array(repeating: "☆", count: 5 - note)
        
        fullStar.append(contentsOf: emptyStar)
        let starEvaluation = fullStar.joined()
        return starEvaluation
    }
    
    public func attributedString(title: String, valueText: String, titleFontSize: CGFloat, valueTextFontSize: CGFloat) -> NSAttributedString {
          let text = NSMutableAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: titleFontSize, weight: .bold)])
          text.append(NSAttributedString(string: valueText, attributes: [.font: UIFont.systemFont(ofSize: valueTextFontSize, weight: .regular)]))
        return text
    }
}
