//
//  BookDetailViewController.swift
//  BookWorm
//
//  Created by 박다혜 on 2023/07/31.
//

import UIKit
import Kingfisher

class BookDetailViewController: UIViewController {

    @IBOutlet var bookCoverImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var memoTextView: UITextView!

    static let identifier = "BookDetailViewController"
    let placeholder = "메모를 입력해주세요"

    var bookInfo: BookTable?
    var type: TransitionType?

    override func viewDidLoad() {
        super.viewDidLoad()

        memoTextView.delegate = self

        memoTextView.text = placeholder
        memoTextView.textColor = .lightGray

        guard let bookInfo else { return }
        let image = loadImageFromDocument(fileName: "cover_\(bookInfo._id).jpg")
        bookCoverImageView.image = image
        titleLabel.text = bookInfo.title
        infoLabel.text = bookInfo.authors
        //overviewLabel.text =

        if !(type == .main) {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
            navigationItem.leftBarButtonItem?.tintColor = .black
        }

        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
    }

    @objc
    func closeButtonClicked() {
        dismiss(animated: true)
    }

}

extension BookDetailViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        if memoTextView.text == placeholder {
            memoTextView.text = nil
            memoTextView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if memoTextView.text.isEmpty {
            memoTextView.text = placeholder
            memoTextView.textColor = .lightGray
        }
    }
}
