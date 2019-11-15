//
//  BookController.swift
//  Project 3 Harrison Kyle
//
//  Created by IS 543 on 11/11/19.
//  Copyright © 2019 IS 543. All rights reserved.
//

import UIKit

class BookController : UITableViewController {
    
    
    var books: [Book] = []
    var newTitle: String = ""
    
    override func viewDidLoad () {
        super.viewDidLoad()
        books = GeoDatabase.shared.booksForParentId(SelectedRows.volumeId ?? 1)
        SelectedRows.possibleBooks = books

    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? UITableViewController {
            if let volume = sender {
                nextViewController.title = newTitle
//                    (volume as AnyObject).text
                print(volume)

            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        cell.textLabel?.text = books[indexPath.item].fullName
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        SelectedRows.selectedName = self.tableView.cellForRow(at: indexPath)?.textLabel?.text
        
        if let chapterNumber = SelectedRows.selectedBook?.numChapters {
            if (chapterNumber < 2) {
                SelectedRows.selectedChapter = 1
                    performSegue(withIdentifier: "BookToScripture", sender: self)
                }
            else {
                newTitle = (self.tableView.cellForRow(at: indexPath)?.textLabel?.text)!
                performSegue(withIdentifier: "BookToChapter", sender: self)
            }
        }
        else {
            performSegue(withIdentifier: "BookToScripture", sender: self)

        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count;
    }


    
}
