//
//  RecentSurveyedTableViewCell.swift
//  The Books
//
//  Created by Luis Gustavo Oliveira Silva on 08/11/20.
//

import UIKit

class RecentSurveyedTableViewCell: UITableViewCell {

    static let reuseIdentifier = "recentSurveyedTableViewCell"

    private lazy var searchName: UILabel = {
        let searchName = UILabel()
        searchName.font = .boldSystemFont(ofSize: 20)
        searchName.numberOfLines = 0
        searchName.translatesAutoresizingMaskIntoConstraints = false
        return searchName
    }()
    
}

extension RecentSurveyedTableViewCell {
    public func setupCell(name: NSAttributedString) {
        searchName.attributedText = name
    }
}

extension RecentSurveyedTableViewCell: ViewCodeType {
    func buildViewHierarchy() {
        addSubview(searchName)
    }
    
    func setupConstraints() {
        searchName.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            topConstant: 10,
            leftConstant: 20,
            bottomConstant: 10,
            rightConstant: 20
        )
    }
    
    func setupAdditionalConfiguration() {
        
    }
    
}
