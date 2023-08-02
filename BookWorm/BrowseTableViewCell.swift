//
//  BrowseTableViewCell.swift
//  BookWorm
//
//  Created by 박다혜 on 2023/08/02.
//

import UIKit

class BrowseTableViewCell: UITableViewCell {

    @IBOutlet var bookCoverImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bookInfoLabel: UILabel!

    static let identifier = "BrowseTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setBookInfo(_ item: Movie) {
        bookCoverImageView.image = UIImage(named: "\(item.title)")
        titleLabel.text = item.title
        bookInfoLabel.text = "\(item.releaseDate) ・ \(item.rate)"
    }
    
}
