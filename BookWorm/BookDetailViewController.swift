//
//  BookDetailViewController.swift
//  BookWorm
//
//  Created by 박다혜 on 2023/07/31.
//

import UIKit
import RealmSwift

class BookDetailViewController: UIViewController {

    @IBOutlet var bookCoverImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var memoTextView: UITextView!

    static let identifier = "BookDetailViewController"
    let placeholder = "메모를 입력해주세요"

    let realm = try! Realm()

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
        memoTextView.text = bookInfo.memo
        //overviewLabel.text =

        if !(type == .main) {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
            navigationItem.leftBarButtonItem?.tintColor = .black
        }

        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""

        let saveButton = UIBarButtonItem(title: "save", style: .done, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
    }

    @objc
    func closeButtonClicked() {
        dismiss(animated: true)
    }

    @objc
    func saveButtonClicked() {
        guard let bookInfo else { return }
        do {
            try realm.write {
                realm.create(BookTable.self, value: ["_id": bookInfo._id, "title": bookInfo.title, "authors": bookInfo.authors, "thumbnail": bookInfo.thumbnail, "": bookInfo.liked, "memo": memoTextView.text ?? ""], update: .modified)
            }
        } catch {
            print("")
        }
        navigationController?.popViewController(animated: true)
    }

    @IBAction func deleteButtonDidTap(_ sender: UIBarButtonItem) {
        guard let bookInfo else { return }
        removeImageFromDocument(fileName: "cover_\(bookInfo._id).jpg")

        try! realm.write {
            realm.delete(bookInfo)
        }

        navigationController?.popViewController(animated: true)
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
