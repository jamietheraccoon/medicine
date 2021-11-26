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
    var medicine: [MedicineListEntry] = []
    // list to hold search results filtered from original medicine list
    var searchResults: [MedicineListEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        // parse medicine.json using helper functions
        let data = readLocalFile(file: "medicine")
        guard let data = data else {
            return
        }
        
        let medicineList = parse(data: data)
        guard let medicineList = medicineList else {
            return
        }
        
        medicine = medicineList.medicine
        searchResults = medicineList.medicine
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
    
    // pass the selected medicine from the selected row into the MedicineViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MedicineSegue" {
            if let destination = segue.destination as? MedicineViewController {
                destination.medicine = searchResults[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
    
    // read local json file into data
    func readLocalFile(file: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: file, ofType: "json") {
                let fileURL = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileURL)
                return data
            }
        } catch {
            print("\(error)")
        }
        return nil
    }
    
    // parse JSON data into MedicineList type (to be used for the table view)
    func parse(data: Data) -> MedicineList? {
        do {
            let decodedData = try JSONDecoder().decode(MedicineList.self, from: data)
            return decodedData
        } catch {
            print("\(error)")
        }
        return nil
    }
}

