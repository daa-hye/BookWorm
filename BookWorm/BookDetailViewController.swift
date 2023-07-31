//
//  BookDetailViewController.swift
//  BookWorm
//
//  Created by 박다혜 on 2023/07/31.
//

import UIKit

class BookDetailViewController: UIViewController {

    var bookTitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        title = bookTitle
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
    }

}
