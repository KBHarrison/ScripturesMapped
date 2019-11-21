//
//  VolumeController.swift
//  Project 3 Harrison Kyle
//
//  Created by IS 543 on 10/30/19.
//  Copyright © 2019 IS 543. All rights reserved.
//
import UIKit
import Foundation

class VolumeController : UITableViewController {
    var books: [Book] = GeoDatabase.shared.volumes()

    
    override func viewDidLoad () {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let selectionIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selectionIndexPath, animated: animated)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VolumeCell", for: indexPath)
        cell.textLabel?.text = books[indexPath.item].fullName
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        RowSelector.shared.volumeId = indexPath.row + 1
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? UITableViewController {
            if let volume = sender {
                nextViewController.title = (volume as AnyObject).text

            }
        }
    }
}
