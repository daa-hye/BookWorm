//
//  BookListCollectionViewController.swift
//  BookWorm
//
//  Created by 박다혜 on 2023/07/31.
//

import UIKit
import RealmSwift

class BookListCollectionViewController: UICollectionViewController {

    var books: Results<BookTable>!

    var type: TransitionType = .main

    override func viewDidLoad() {
        super.viewDidLoad()

        let realm = try! Realm()
        print(realm.configuration.fileURL)
        books = realm.objects(BookTable.self)

        let nib = UINib(nibName: BookListCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: BookListCollectionViewCell.identifier)
        setLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
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
        viewController.bookInfo = books[indexPath.row]
        viewController.type = type
        navigationController?.pushViewController(viewController, animated: true)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookListCollectionViewCell.identifier, for: indexPath) as? BookListCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = books[indexPath.row]
        cell.setBookInfo(item)
        let image = loadImageFromDocument(fileName: "cover_\(item._id).jpg")
        cell.bookCoverImageView.image = image
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonDidTap), for: .touchUpInside)

        return cell
    }

    @objc
    func likeButtonDidTap(_ sender: UIButton) {
        books[sender.tag].liked.toggle()
    }

}

