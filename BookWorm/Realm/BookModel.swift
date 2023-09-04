//
//  BookModel.swift
//  BookWorm
//
//  Created by 박다혜 on 2023/09/04.
//

import Foundation
import RealmSwift

class BookTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var thumbnail: String
    @Persisted var authors: String
    @Persisted var liked: Bool

    convenience init(title: String, thumbnail: String, authors: String) {
        self.init()

        self.title = title
        self.thumbnail = thumbnail
        self.authors = authors
        self.liked = false
    }
}
