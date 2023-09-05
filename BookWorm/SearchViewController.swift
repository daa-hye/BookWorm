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
import RealmSwift

class SearchViewController: UIViewController {

    @IBOutlet var searchTableView: UITableView!
    static let identifier = "SearchViewController"
    
    let searchBar = UISearchBar()
    let maxPage = 50

    var searchedBook: [Book] = []
    var page = 1
    var isEnd = false

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력해주세요"
        searchBar.showsCancelButton = false

        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.prefetchDataSource = self

        let nib = UINib(nibName: BrowseTableViewCell.identifier, bundle: nil)
        searchTableView.register(nib, forCellReuseIdentifier: BrowseTableViewCell.identifier)

        title = "검색화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonDidTap))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.titleView = searchBar

        searchTableView.rowHeight = 140

    }

    @objc
    func closeButtonDidTap() {
        dismiss(animated: true)
    }

    func callRequest(_ text: String, page: Int) {

        guard let searchText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = "https://dapi.kakao.com/v3/search/book?query=\(searchText)&size=10&page=\(page)"
        let header: HTTPHeaders = ["Authorization" : "\(APIKey.kakaoAK)"]

        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)

                        let statusCode = response.response?.statusCode ?? 500
                        guard statusCode == 200 else { return }

                        self.isEnd = json["meta"]["is_end"].boolValue

                        for item in json["documents"].arrayValue {

                            let title = item["title"].stringValue
                            let thumbnail = item["thumbnail"].stringValue
                            let authors = item["authors"].arrayValue.map({$0.stringValue})
                            let authorList = authors.joined(separator: ",")

                            let data = Book(title: title, thumbnail: thumbnail, authors: authorList)

                            self.searchedBook.append(data)
                        }

                        self.searchTableView.reloadData()

                    case .failure(let error):
                        print(error)
                    }
                }
    }

}

extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        searchedBook.removeAll()
        guard let text = searchBar.text else { return }
        callRequest(text, page: page)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchedBook.removeAll()
        searchBar.text = ""
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
    }

//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchBar.showsCancelButton = true
//        guard let text = searchBar.text , let searchText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
//        getBookImageFromServer(searchText)
//    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedBook.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BrowseTableViewCell.identifier) as? BrowseTableViewCell else { return UITableViewCell() }
        cell.setBookInfo(book: searchedBook[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cell = tableView.cellForRow(at: indexPath) as! BrowseTableViewCell
        let realm = try! Realm()
        let book = searchedBook[indexPath.row]

        let task = BookTable(title: book.title, thumbnail: book.thumbnail, authors: book.authors)

        try! realm.write {
            realm.add(task)
        }

        if let image = cell.bookCoverImageView.image {
            saveImageToDocument(fileName: "cover_\(task._id).jpg", image: image)
        }
        
        dismiss(animated: true)
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if searchedBook.count - 1 == indexPath.row && page < maxPage && isEnd == false {
                page += 1
                callRequest(searchBar.text!, page: page)
            }
        }
    }

    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("=====취소 : \(indexPaths)")
    }

}
