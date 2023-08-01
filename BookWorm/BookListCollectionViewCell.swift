//
//  BookListCollectionViewCell.swift
//  BookWorm
//
//  Created by 박다혜 on 2023/07/31.
//

import UIKit

class BookListCollectionViewCell: UICollectionViewCell {

    @IBOutlet var backdropUIView: UIView!
    @IBOutlet var bookCoverImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var likeButton: UIButton!

    static let identifier = "BookListCollectionViewCell"

    func setBookInfo(_ item: Movie) {
        backdropUIView.setRandomBackgroundColor()
        backdropUIView.setCornerRound()

        bookCoverImageView.image = UIImage(named: "\(item.title)")
        titleLabel.text = item.title
        rateLabel.text = "\(item.rate)점"
        if item.like {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
}
