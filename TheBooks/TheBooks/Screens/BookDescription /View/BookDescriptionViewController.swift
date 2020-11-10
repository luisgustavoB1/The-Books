//
//  BookDescriptionViewController.swift
//  The Books
//
//  Created by Luis Gustavo Oliveira Silva on 05/11/20.
//

import UIKit

class BookDescriptionViewController: UIViewController {
    
    private let bookDescriptionViewModel: BookDescriptionViewModel
    
    init(
        bookDescriptionViewModel: BookDescriptionViewModel
    ) {
        self.bookDescriptionViewModel = bookDescriptionViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var trackName: UILabel = {
        let trackName = UILabel()
        trackName.text = bookDescriptionViewModel.book.trackName
        trackName.font = .boldSystemFont(ofSize: 14)
        trackName.numberOfLines = 0
        trackName.translatesAutoresizingMaskIntoConstraints = false
        return trackName
    }()
    
    private lazy var artistName: UILabel = {
        let artistName = UILabel()
        artistName.text = bookDescriptionViewModel.book.artistName
        artistName.font = .italicSystemFont(ofSize: 12)
        artistName.numberOfLines = 2
        artistName.translatesAutoresizingMaskIntoConstraints = false
        return artistName
    }()
    
    private lazy var bookImage: UIImageView = {
        let bookImage = UIImageView()
        bookImage.sd_setImage(with: URL(string: bookDescriptionViewModel.book.artworkUrl100))
        return bookImage
    }()
    
    private lazy var bookDescription: UILabel = {
        let bookDescription = UILabel()
        bookDescription.attributedText = bookDescriptionViewModel.attributedString(title: "Description:  \n", valueText: bookDescriptionViewModel.book.description, titleFontSize: 14, valueTextFontSize: 12)
        bookDescription.numberOfLines = 0
        bookDescription.translatesAutoresizingMaskIntoConstraints = false
        return bookDescription
    }()
    
    private lazy var bookUrl: UIButton = {
        let bookUrl = UIButton()
        bookUrl.setTitle("More Detail", for: .normal)
        bookUrl.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        bookUrl.clipsToBounds = true
        bookUrl.layer.cornerRadius = 10
        bookUrl.addTarget(self, action: #selector(actionButtonBookUrl), for: .touchUpInside)
        return bookUrl
    }()
    
    private lazy var averageRating: UILabel = {
        let averageRating = UILabel()
        averageRating.attributedText = bookDescriptionViewModel.attributedString(title: "Average Rating: ", valueText: bookDescriptionViewModel.starEvaluation(note: Int(bookDescriptionViewModel.book.artworkUrl100) ?? 00), titleFontSize: 14, valueTextFontSize: 12)
        averageRating.numberOfLines = 0
        averageRating.translatesAutoresizingMaskIntoConstraints = false
        return averageRating
    }()
    
    private lazy var price: UILabel = {
        let price = UILabel()
        price.attributedText = bookDescriptionViewModel.attributedString(title: "Price: ", valueText: bookDescriptionViewModel.book.formattedPrice, titleFontSize: 14, valueTextFontSize: 12)
        price.numberOfLines = 0
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    private lazy var bookKind: UILabel = {
        let bookKind = UILabel()
        bookKind.attributedText = bookDescriptionViewModel.attributedString(title: "Kind: ", valueText: bookDescriptionViewModel.book.kind, titleFontSize: 14, valueTextFontSize: 12)
        bookKind.numberOfLines = 0
        bookKind.translatesAutoresizingMaskIntoConstraints = false
        return bookKind
    }()
    
    @objc func actionNavItem () {
       dismiss(animated: true)
    }
    
    @objc func actionButtonBookUrl () {
        guard let urlBookDescriptionLink = URL(string: bookDescriptionViewModel.book.trackViewUrl) else { return }
        UIApplication.shared.open(urlBookDescriptionLink)
    }
}

// MARK: - View Code
extension BookDescriptionViewController: ViewCodeType {
    func buildViewHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(bookImage)
        contentView.addSubview(trackName)
        contentView.addSubview(artistName)
        contentView.addSubview(bookDescription)
        contentView.addSubview(averageRating)
        contentView.addSubview(price)
        contentView.addSubview(bookKind)
        contentView.addSubview(bookUrl)
        
    }
    
    func setupConstraints() {
        
        scrollView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )
        
        contentView.anchor(
            top: scrollView.topAnchor,
            left: scrollView.leftAnchor,
            bottom: scrollView.bottomAnchor,
            right: scrollView.rightAnchor,
            widthConstant: view.bounds.size.width
        )
        
        bookImage.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            topConstant: 20,
            leftConstant: 20,
            widthConstant: 100,
            heightConstant: 130
        )
        
        trackName.anchor(
            top: bookImage.topAnchor,
            left: bookImage.rightAnchor,
            right: contentView.rightAnchor,
            leftConstant: 5,
            rightConstant: 10
        )
        
        artistName.anchor(
            top: trackName.bottomAnchor,
            left: trackName.leftAnchor,
            right: trackName.rightAnchor,
            topConstant: 10
        )
        
        bookDescription.anchor(
            top: bookImage.bottomAnchor,
            left: bookImage.leftAnchor,
            right: contentView.rightAnchor,
            topConstant: 15,
            rightConstant: 20
        )
        
        averageRating.anchor(
            top: bookDescription.bottomAnchor,
            left: bookDescription.leftAnchor,
            right: bookDescription.rightAnchor,
            topConstant: 15
        )
        
        price.anchor(
            top: averageRating.bottomAnchor,
            left: averageRating.leftAnchor,
            right: averageRating.rightAnchor,
            topConstant: 15
        )
        
        bookKind.anchor(
            top: price.bottomAnchor,
            left: price.leftAnchor,
            right: price.rightAnchor,
            topConstant: 15
        )
        
        bookUrl.anchor(
            top: bookKind.bottomAnchor,
            left: bookKind.leftAnchor,
            bottom: contentView.bottomAnchor,
            right: bookKind.rightAnchor,
            topConstant: 15,
            bottomConstant: 15
        )
        
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = "Book"
        let barItem = UIBarButtonItem(title: "Exit", style: .done, target: self, action: #selector(actionNavItem))
        navigationItem.rightBarButtonItem = barItem
    }
    
}
