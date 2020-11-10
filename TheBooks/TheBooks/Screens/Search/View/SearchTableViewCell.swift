//
//  SearchTableViewCell.swift
//  The Books
//
//  Created by Luis Gustavo Oliveira Silva on 05/11/20.
//

import UIKit
import SDWebImage

class SearchTableViewCell: UITableViewCell {

    static let reuseIdentifier = "searchTableViewCell"
    
    private lazy var trackName: UILabel = {
        let trackName = UILabel()
        trackName.font = .boldSystemFont(ofSize: 14)
        trackName.numberOfLines = 0
        trackName.translatesAutoresizingMaskIntoConstraints = false
        return trackName
    }()
    
    private lazy var artistName: UILabel = {
        let artistName = UILabel()
        artistName.font = .italicSystemFont(ofSize: 12)
        artistName.numberOfLines = 1
        artistName.translatesAutoresizingMaskIntoConstraints = false
        return artistName
    }()
    
    private lazy var bookImage: UIImageView = {
        let bookImage = UIImageView()
        return bookImage
    }()

}

// MARK: - Setup Cell
extension SearchTableViewCell {
    
    public func setupCell(name: String, artist: String, image: String) {
        trackName.text = name
        artistName.text = artist
        bookImage.sd_setImage(with: URL(string: image))
    }

}

// MARK: - View Code
extension SearchTableViewCell: ViewCodeType {
    func buildViewHierarchy() {
        addSubview(bookImage)
        addSubview(trackName)
        addSubview(artistName)
    }
    
    func setupConstraints() {
        
        bookImage.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            topConstant: 10,
            leftConstant: 20,
            bottomConstant: 10,
            widthConstant: 100,
            heightConstant: 120
        )
        
        trackName.anchor(
            top: bookImage.topAnchor,
            left: bookImage.rightAnchor,
            right: rightAnchor,
            leftConstant: 5,
            rightConstant: 10
        )
        
        artistName.anchor(
            top: trackName.bottomAnchor,
            left: trackName.leftAnchor,
            right: trackName.rightAnchor,
            topConstant: 10
        )
        
    }
    
    func setupAdditionalConfiguration() {
        
    }

}
