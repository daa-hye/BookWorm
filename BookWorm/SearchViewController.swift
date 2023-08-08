//
//  SearchViewController.swift
//  BookWorm
//
//  Created by 박다혜 on 2023/07/31.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class SearchViewController: UIViewController {

    @IBOutlet var searchCollectionView: UICollectionView!

    static let identifier = "SearchViewController"
    
    let searchBar = UISearchBar()
    let movieInfo = MovieInfo()
    var searchedMovie: [Movie] = []

    var searchedBook: [String] = []

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

    func getBookImageFromServer(_ text: String) {
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)"
        //let header: HTTPHeaders = ["Authorization" : "\(APIKey.kakaoAK)"]

        AF.request(url, method: .get).validate().responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let totalCount = json["total_count"].intValue
                        let bookList = json["documents"].arrayValue
                        for i in 0..<bookList.count {
                            let bookImage = bookList[i]["thumbnail"].stringValue
                            self.searchedBook.append(bookImage)
                        }
                        print("JSON: \(json)")
                    case .failure(let error):
                        print(error)
                    }
                }
    }

}

extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        searchedBook.removeAll()
        getBookImageFromServer(searchText)
        searchCollectionView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchedBook.removeAll()
        searchBar.text = ""
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        searchCollectionView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        searchedBook.removeAll()
        guard let searchText = searchBar.text else { return }
        getBookImageFromServer(searchText)
        searchCollectionView.reloadData()
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedBook.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrowseCollectionViewCell.identifier, for: indexPath) as? BrowseCollectionViewCell else { return UICollectionViewCell() }
        guard let bookImageUrl = URL(string: searchedBook[indexPath.row]) else { return UICollectionViewCell() }
        cell.setBookImage(bookImageUrl)
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
