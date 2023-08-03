//
//  SearchViewController.swift
//  BookWorm
//
//  Created by 박다혜 on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var searchCollectionView: UICollectionView!

    static let identifier = "SearchViewController"
    
    let searchBar = UISearchBar()
    let movieInfo = MovieInfo()
    var searchedMovie: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력해주세요"
        searchBar.showsCancelButton = false

        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self

        let nib = UINib(nibName: BrowseCollectionViewCell.identifier, bundle: nil)
        searchCollectionView.register(nib, forCellWithReuseIdentifier: BrowseCollectionViewCell.identifier)

        title = "검색화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonDidTap))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.titleView = searchBar
        
        setCollectionViewLayout()
    }

    @objc
    func closeButtonDidTap() {
        dismiss(animated: true)
    }

}

extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        searchedMovie.removeAll()
        for item in searchedMovie {
            if item.title.contains(searchText) {
                searchedMovie.append(item)
            }
        }
        searchCollectionView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchedMovie.removeAll()
        searchBar.text = ""
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        searchCollectionView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        searchedMovie.removeAll()
        guard let searchText = searchBar.text else { return }
        for item in movieInfo.movieList {
            if item.title.contains(searchText) {
                searchedMovie.append(item)
            }
        }
        searchCollectionView.reloadData()
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedMovie.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrowseCollectionViewCell.identifier, for: indexPath) as? BrowseCollectionViewCell else { return UICollectionViewCell() }
        cell.setBookImage(searchedMovie[indexPath.row])
        return cell
    }

    func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        searchCollectionView.collectionViewLayout = layout
    }

}
