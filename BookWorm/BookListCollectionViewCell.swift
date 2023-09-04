//
//  BookListCollectionViewCell.swift
//  BookWorm
//
//  Created by 박다혜 on 2023/07/31.
//

import UIKit
import Kingfisher

class BookListCollectionViewCell: UICollectionViewCell {

    @IBOutlet var backdropUIView: UIView!
    @IBOutlet var bookCoverImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var likeButton: UIButton!

    static let identifier = "BookListCollectionViewCell"

    func setBookInfo(_ item: BookTable) {
        backdropUIView.setCornerRound()
        backdropUIView.backgroundColor = .cyan
        guard let url = URL(string: item.thumbnail) else { return }
        bookCoverImageView.kf.setImage(with: url)
        titleLabel.text = item.title
        rateLabel.text = item.authors
        item.liked ? likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) : likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
}
