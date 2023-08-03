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
        backdropUIView.setCornerRound()
        backdropUIView.backgroundColor = UIColor(red: item.randomBackgroundColor[0], green: item.randomBackgroundColor[1], blue: item.randomBackgroundColor[2], alpha: 1)
        bookCoverImageView.image = UIImage(named: "\(item.title)")
        titleLabel.text = item.title
        rateLabel.text = "\(item.rate)점"
        item.like ? likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) : likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
}
