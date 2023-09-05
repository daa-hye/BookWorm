//
//  BrowseViewController.swift
//  BookWorm
//
//  Created by 박다혜 on 2023/08/02.
//

import UIKit

class BrowseViewController: UIViewController {

    @IBOutlet var browseCollectionView: UICollectionView!
    @IBOutlet var browseTableView: UITableView!

    var movieInfo = MovieInfo()
    var recentClickedIndex: [Int] = [] {
        didSet {
            browseCollectionView.reloadData()
        }
    }
    
    let tableType: TransitionType = .tableDetail
    let collectionType: TransitionType = .collectionDetail

    let recentCount = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        let tableNib = UINib(nibName: BrowseTableViewCell.identifier, bundle: nil)
        let collectionNib = UINib(nibName: BrowseCollectionViewCell.identifier, bundle: nil)
        browseTableView.register(tableNib, forCellReuseIdentifier: BrowseTableViewCell.identifier)
        browseCollectionView.register(collectionNib, forCellWithReuseIdentifier: BrowseCollectionViewCell.identifier)

        browseTableView.delegate = self
        browseTableView.dataSource = self

        browseCollectionView.delegate = self
        browseCollectionView.dataSource = self

        setCollectionViewLayout()
    }

    func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        browseCollectionView.collectionViewLayout = layout
    }

}

extension BrowseViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "요즘 인기 작품"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieInfo.movieList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BrowseTableViewCell.identifier) as? BrowseTableViewCell else {
            return UITableViewCell()
        }
        cell.setBookInfo(movieInfo.movieList[indexPath.row])
        return cell
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        guard let vc = storyboard?.instantiateViewController(withIdentifier: BookDetailViewController.identifier) as? BookDetailViewController else { return }
//        let navigator = UINavigationController(rootViewController: vc)
//        navigator.modalPresentationStyle = .fullScreen
//        vc.bookInfo = movieInfo.movieList[indexPath.row]
//        vc.type = tableType
//        present(navigator, animated: true)
//        if !recentClickedIndex.contains(indexPath.row) {
//            recentClickedIndex.insert(indexPath.row, at: 0)
//        }
//        tableView.reloadRows(at: [indexPath], with: .none)
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
}

extension BrowseViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentClickedIndex.count < recentCount ? recentClickedIndex.count : recentCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrowseCollectionViewCell.identifier, for: indexPath) as? BrowseCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setBookImage(movieInfo.movieList[recentClickedIndex[indexPath.row]])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: BookDetailViewController.identifier) as? BookDetailViewController else { return }
        let navigator = UINavigationController(rootViewController: vc)
        navigator.modalPresentationStyle = .fullScreen
        //vc.bookInfo = movieInfo.movieList[recentClickedIndex[indexPath.row]]
        //vc.type = collectionType
        //present(navigator, animated: true)
    }
}
