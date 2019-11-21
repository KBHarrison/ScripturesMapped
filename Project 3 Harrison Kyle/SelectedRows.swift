//
//  SelectedRows.swift
//  Project 3 Harrison Kyle
//
//  Created by IS 543 on 11/11/19.
//  Copyright © 2019 IS 543. All rights reserved.
//

import Foundation

class SelectedRows {
    var volumeId: Int?
    var bookId: Int?
    var chapterId: Int?
    var selectedChapter: Int?
    var possibleBooks: [Book]?
    var selectedName: String?
    var selectedBook: Book? {
        if let bookList = possibleBooks {
            if let name = selectedName {
                return bookList.filter { $0.fullName == name }[0]
            }
            else {return nil}
        }
        else {return nil}
    }
}

class RowSelector {
    static var shared = SelectedRows()
    init() {
        
    }
}
