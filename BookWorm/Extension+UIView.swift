//
//  Extension+UIView.swift
//  BookWorm
//
//  Created by 박다혜 on 2023/07/31.
//

import UIKit

extension UIView {

    func setRandomBackgroundColor() {
        let randomRed = CGFloat.random(in: 0...1)
        let randomGreen = CGFloat.random(in: 0...1)
        let randomBlue = CGFloat.random(in: 0...1)
        self.backgroundColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1)
    }

    func setCornerRound() {
        self.layer.cornerRadius = 15
    }

}
