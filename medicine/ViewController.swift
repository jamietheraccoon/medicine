//
//  ViewController.swift
//  medicine
//
//  Created by jamie on 11/16/21.
//

import UIKit

class ViewController: UITableViewController {
    var medicine: [Medicine] = [
        Medicine(name: "Example medicine 1", file: ""),
        Medicine(name: "Example medicine 2", file: ""),
        Medicine(name: "Example medicine 3", file: "")
    ]
    var searchResults: [Medicine] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResults = medicine
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicineCell", for: indexPath)
        // set cell text row to correspondong medicine name
        cell.textLabel?.text = searchResults[indexPath.row].name;
        return cell
    }
}

