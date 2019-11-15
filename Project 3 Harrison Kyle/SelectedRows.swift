//
//  SelectedRows.swift
//  Project 3 Harrison Kyle
//
//  Created by IS 543 on 11/11/19.
//  Copyright © 2019 IS 543. All rights reserved.
//

import Foundation

class SelectedRows {
    static var volumeId: Int?
    static var bookId: Int?
    static var chapterId: Int?
    static var selectedChapter: Int?
    static var possibleBooks: [Book]?
    static var selectedName: String?
    static var selectedBook: Book? {
        if let bookList = possibleBooks {
            if let name = selectedName {
                return bookList.filter { $0.fullName == name }[0]
            }
            else {return nil}
        }
        else {return nil}
    }
}
