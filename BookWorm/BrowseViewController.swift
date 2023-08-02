//
//  BrowseViewController.swift
//  BookWorm
//
//  Created by 박다혜 on 2023/08/02.
//

import UIKit

class BrowseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var browseCollectionView: UICollectionView!
    @IBOutlet var browseTableView: UITableView!

    var movieInfo = MovieInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        let tableNib = UINib(nibName: BrowseTableViewCell.identifier, bundle: nil)
        let collectionNib = UINib(nibName: BrowseCollectionViewCell.identifier, bundle: nil)
        browseTableView.register(tableNib, forCellReuseIdentifier: BrowseTableViewCell.identifier)
        browseCollectionView.register(collectionNib, forCellWithReuseIdentifier: BrowseCollectionViewCell.identifier)

        browseTableView.delegate = self
        browseTableView.dataSource = self

        browseCollectionView.delegate = self
        browseCollectionView.delegate = self

        setCollectionViewLayout()
    }

    func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        //layout.itemSize = CGSize(width: 50, height: 65)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        browseCollectionView.collectionViewLayout = layout
    }

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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieInfo.movieList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrowseCollectionViewCell.identifier, for: indexPath) as? BrowseCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setBookImage(movieInfo.movieList[indexPath.row])
        return cell
    }

}
