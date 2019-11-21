//
//  ChapterController.swift
//  Project 3 Harrison Kyle
//
//  Created by IS 543 on 11/11/19.
//  Copyright © 2019 IS 543. All rights reserved.
//
import UIKit
import Foundation


class ChapterController : UITableViewController {
    
    var rowTitle: String?
    
    override func viewDidLoad () {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "BookToScripture" {
            if let test = sender as? UITableViewCell {
                if let title = test.textLabel?.text {
                    segue.destination.title = title
                }
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterCell", for: indexPath)
        if let subdivisionName = RowSelector.shared.selectedBook?.subdiv {
            cell.textLabel?.text = "\(subdivisionName) \(indexPath.row + 1)"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        RowSelector.shared.selectedChapter = indexPath.row + 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rows = RowSelector.shared.selectedBook?.numChapters {
            return rows
        }
        return 0
    }
    
}
