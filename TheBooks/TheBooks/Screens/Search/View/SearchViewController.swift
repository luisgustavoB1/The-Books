//
//  ViewController.swift
//  The Books
//
//  Created by Luis Gustavo Oliveira Silva on 04/11/20.
//

import UIKit

class SearchViewController: UIViewController {
    
    var searchViewModel: SearchViewModel = SearchViewModel()
    var navItemState = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        searchViewModel.fetchBookList { state in
            guard case .success = state else { return }
        }
        searchViewModel.delegate = self
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
        tableView.register(RecentSurveyedTableViewCell.self, forCellReuseIdentifier: RecentSurveyedTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = "Apple Books"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var errorView: UIView = {
        let errorView = UIView()
        errorView.isHidden = true
        errorView.translatesAutoresizingMaskIntoConstraints = false
        return errorView
    }()
    
    private lazy var errorMessage: UILabel = {
        let errorMessage = UILabel()
        errorMessage.text = "Unfortunately the book was not found!"
        errorMessage.font = .boldSystemFont(ofSize: 20)
        errorMessage.textAlignment = .center
        errorMessage.numberOfLines = 0
        errorMessage.translatesAutoresizingMaskIntoConstraints = false
        return errorMessage
    }()
    
    private lazy var errorImage: UIImageView = {
        let error = UIImageView()
        error.image = UIImage(named: "caraCarrancuda")
        return error
    }()
    
    private func setupBookDescription(at index: Int) {
        let bookDescription = BookDescriptionViewController(
            bookDescriptionViewModel: BookDescriptionViewModel(
                book: searchViewModel.filteredList[index]
            )
        )
        self.navigationController?.present(UINavigationController(rootViewController: bookDescription), animated: true)
    }
    
    private func setupRecentSurveyed(at index: Int) {
        if index > 0 {
            searchBar.text = searchViewModel.recentSurveyed[index]
            searchBarSearchButtonClicked(searchBar)
        }
    }
    
    private func setupNavItem(title: String) {
        let barItem = UIBarButtonItem(title: title, style: .done, target: self, action: #selector(actionNavItem))
        navigationItem.rightBarButtonItem = barItem
    }
    
    @objc func actionNavItem () {
        if navItemState {
            searchViewModel.clearList()
            searchViewModel.tableViewType = .searchResult
            tableView.isHidden = false
            searchViewModel.fullList()
            setupNavItem(title: "Remove List")
            navItemState = false
        } else {
            setupRecentSurveyed()
            searchViewModel.clearList()
            setupNavItem(title: "Full list")
            navItemState = true
        }
    }
}

// MARK: - Table View
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch searchViewModel.tableViewType {
        case .searchResult:
            guard let searchResult = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath as IndexPath) as? SearchTableViewCell else { return UITableViewCell() }
            
            searchResult.selectionStyle = .none
            searchResult.setupView()
            searchResult.setupCell(
                name: searchViewModel.setBookName(at: indexPath.row),
                artist: searchViewModel.setBookArtist(at: indexPath.row),
                image: searchViewModel.setBookImage(at: indexPath.row)
            )
            
            return searchResult
            
        case .recentSurveyed:
            guard let recentSurveyed = tableView.dequeueReusableCell(withIdentifier: RecentSurveyedTableViewCell.reuseIdentifier, for: indexPath as IndexPath) as? RecentSurveyedTableViewCell else { return UITableViewCell() }
            
            recentSurveyed.selectionStyle = .none
            recentSurveyed.setupView()
            recentSurveyed.setupCell(
                name: searchViewModel.attributedString(text: searchViewModel.setRecentSurveyedName(at: indexPath.row), index: indexPath.row)
            )
            
            return recentSurveyed
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        switch searchViewModel.tableViewType {
        case .searchResult:
            setupBookDescription(at: index)
            
        case .recentSurveyed:
            setupRecentSurveyed(at: index)
        }
    }
    
}

extension SearchViewController: SearchViewModelDelegate {
    func reloadData() {
        self.tableView.reloadData()
    }
}

// MARK: - Search Bar
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            cancelSearch()
        } else {
            searchBar.setShowsCancelButton(true, animated: true)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchViewModel.tableViewType = .searchResult
        let searchState = searchViewModel.searchFilter(name: searchBar.text ?? "")
        tableView.isHidden = false
        setupError(is: searchState)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cancelSearch()
    }
    
    private func setupError(is state: Int) {
        if state == 0 {
            errorView.isHidden = false
            tableView.isHidden = true
        }
    }
    
    private func cancelSearch() {
        setupRecentSurveyed()
        setupNavItem(title: "Full list")
        navItemState = true
    }
    
    private func setupRecentSurveyed() {
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        searchViewModel.tableViewType = .recentSurveyed
        errorView.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
    }
}

// MARK: - View Code
extension SearchViewController: ViewCodeType {
    func buildViewHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(errorView)
        errorView.addSubview(errorImage)
        errorView.addSubview(errorMessage)
    }
    
    func setupConstraints() {
        searchBar.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor
        )
        
        tableView.anchor(
            top: searchBar.bottomAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )
        
        errorView.anchor(
            left: view.leftAnchor,
            right: view.rightAnchor,
            centerY: view.centerYAnchor,
            leftConstant: 25,
            rightConstant: 25
        )
        
        errorImage.anchor(
            top: errorView.topAnchor,
            centerX: errorView.centerXAnchor,
            widthConstant: 75,
            heightConstant: 75
        )
        
        errorMessage.anchor(
            top: errorImage.bottomAnchor,
            left: errorView.leftAnchor,
            bottom: errorView.bottomAnchor,
            right: errorView.rightAnchor,
            topConstant: 5,
            bottomConstant: 5
        )
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupNavItem(title: "Full list")
    }
}
