//
//  SearchViewController.swift
//  BookWorm
//
//  Created by 박다혜 on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "검색화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonDidTap))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

    @objc
    func closeButtonDidTap() {
        dismiss(animated: true)
    }

}
