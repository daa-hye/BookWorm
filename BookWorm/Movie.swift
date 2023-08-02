//
//  Movie.swift
//  BookWorm
//
//  Created by 박다혜 on 2023/07/31.
//

import Foundation

struct Movie {
    let title: String
    let releaseDate: String
    let runtime: Int
    let overview: String
    var rate: Double
    var like: Bool = false
    var randomBackgroundColor: [CGFloat]
    

    init(title: String, releaseDate: String, runtime: Int, overview: String, rate: Double, randomBackgroundColor: [CGFloat]) {
        self.title = title
        self.releaseDate = releaseDate
        self.runtime = runtime
        self.overview = overview
        self.rate = rate
        self.randomBackgroundColor = randomBackgroundColor
    }

    var movieDetailInfo: String {
        get {
            "\(releaseDate) \t|\t \(runtime)분 \t|\t \(rate)점"
        }
    }

}
