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
    var bookInfo: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let bookInfo else { return }
        title = bookInfo.title
        bookCoverImageView.image = UIImage(named: "\(bookInfo.title)")
        titleLabel.text = bookInfo.title
        infoLabel.text = "\(bookInfo.releaseDate)  |  \(bookInfo.runtime)분  |  \(bookInfo.rate)점"
        overviewLabel.text = bookInfo.overview
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
    }

    @objc
    func closeButtonClicked() {
        dismiss(animated: true)
    }

}
