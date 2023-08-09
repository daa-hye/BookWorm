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

    @IBOutlet var searchTableView: UITableView!
    static let identifier = "SearchViewController"
    
    let searchBar = UISearchBar()

    var searchedBook: [Book] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력해주세요"
        searchBar.showsCancelButton = false

        searchTableView.delegate = self
        searchTableView.dataSource = self

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

    func getBookImageFromServer(_ text: String) {
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)"
        let header: HTTPHeaders = ["Authorization" : "\(APIKey.kakaoAK)"]

        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        self.searchedBook.removeAll()

                        for item in json["documents"].arrayValue {
                            let title = item["title"].stringValue
                            let thumbnail = item["thumbnail"].stringValue
                            let authors = item["authors"].arrayValue.map({$0.stringValue})
                            let authorList = authors.joined(separator: ",")

                            let data = Book(title: title, thumbnail: thumbnail, authors: authorList)

                            self.searchedBook.append(data)
                        }
                        print(self.searchedBook)
                        self.searchTableView.reloadData()

                    case .failure(let error):
                        print(error)
                    }
                }
    }

}

extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text , let searchText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        getBookImageFromServer(searchText)
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

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedBook.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BrowseTableViewCell.identifier) as? BrowseTableViewCell else { return UITableViewCell() }
        cell.setBookInfo(book: searchedBook[indexPath.row])
        return cell
    }

}
