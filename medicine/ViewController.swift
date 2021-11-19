//
//  ViewController.swift
//  medicine
//
//  Created by jamie on 11/16/21.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet var searchBar: UISearchBar!
    
    // list to hold a list of all medicine
    var medicine: [Medicine] = [
        Medicine(name: "example medicine 1", file: ""),
        Medicine(name: "example medicine 2", file: ""),
        Medicine(name: "example medicine 3", file: "")
    ]
    // list to hold search results filtered from original medicine list
    var searchResults: [Medicine] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        searchResults = medicine
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // get the number of rows from the number of search results
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    // displays the rows on the screen
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicineCell", for: indexPath)
        // set cell text row to corresponding medicine name
        cell.textLabel?.text = searchResults[indexPath.row].name.capitalized;
        return cell
    }
    
    // implement search bar logic
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // filter medicine so that every element contains searchText
        searchResults = medicine.filter({ medicine in
            return medicine.name.contains(searchText.lowercased())
        })
        // reload tableview's data
        tableView.reloadData()
    }
}

