//
//  PokemonViewController.swift
//  medicine
//
//  Created by jamie on 11/20/21.
//

import UIKit

class MedicineViewController : UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var concLabel: UILabel!
    
    var medicine: MedicineListEntry!
    var medicineData: MedicineData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get the data from the medicine's json file in the medicineData folder
        let data = readLocalFile(file: medicine.file)
        guard let data = data else {
            return
        }
        
        let medicineData = parse(data: data)
        guard let medicineData = medicineData else {
            return
        }
        
        // set navigation title to medicine name
        navigationItem.title = medicineData.name
        // set text of labels
        nameLabel.text = medicineData.name
        concLabel.text = medicineData.concentration
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
    func parse(data: Data) -> MedicineData? {
        do {
            let decodedData = try JSONDecoder().decode(MedicineData.self, from: data)
            return decodedData
        } catch {
            print("\(error)")
        }
        return nil
    }
}
