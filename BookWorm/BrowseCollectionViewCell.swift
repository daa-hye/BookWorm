//
//  BrowseCollectionViewCell.swift
//  BookWorm
//
//  Created by 박다혜 on 2023/08/02.
//

import UIKit

class BrowseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var bookCoverImageView: UIImageView!

    static let identifier = "BrowseCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setBookImage(_ item: Movie) {
        bookCoverImageView.image = UIImage(named: "\(item.title)")
        print(1)
    }

}
