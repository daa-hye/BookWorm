//
//  BookDetailViewController.swift
//  BookWorm
//
//  Created by 박다혜 on 2023/07/31.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet var bookCoverImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!

    static let identifier = "BookDetailViewController"
    var bookInfo: Movie = Movie(title: "", releaseDate: "", runtime: 0, overview: "", rate: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = bookInfo.title
        bookCoverImageView.image = UIImage(named: "\(bookInfo.title)")
        titleLabel.text = bookInfo.title
        infoLabel.text = "\(bookInfo.releaseDate)  |  \(bookInfo.runtime)분  |  \(bookInfo.rate)점"
        overviewLabel.text = bookInfo.overview
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
    }

}
