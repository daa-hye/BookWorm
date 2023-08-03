//
//  BookListCollectionViewController.swift
//  BookWorm
//
//  Created by 박다혜 on 2023/07/31.
//

import UIKit

class BookListCollectionViewController: UICollectionViewController {

    var movieInfo = MovieInfo() {
        didSet {
            collectionView.reloadData()
        }
    }

    var type: TransitionType = .main

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: BookListCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: BookListCollectionViewCell.identifier)
        setLayout()
    }

    @IBAction func searchButtonDidTap(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: SearchViewController.identifier) as? SearchViewController else {
            return
        }
        let navigator = UINavigationController(rootViewController: viewController)
        navigator.modalPresentationStyle = .fullScreen
        present(navigator, animated: true)
    }


    func setLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width/2, height: width/2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyBoard.instantiateViewController(identifier: BookDetailViewController.identifier) as? BookDetailViewController else {
            return
        }
        viewController.bookInfo = movieInfo.movieList[indexPath.row]
        viewController.type = type
        navigationController?.pushViewController(viewController, animated: true)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieInfo.movieList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookListCollectionViewCell.identifier, for: indexPath) as? BookListCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = movieInfo.movieList[indexPath.row]
        cell.setBookInfo(item)
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonDidTap), for: .touchUpInside)

        return cell
    }

    @objc
    func likeButtonDidTap(_ sender: UIButton) {
        movieInfo.movieList[sender.tag].like.toggle()
    }

}

