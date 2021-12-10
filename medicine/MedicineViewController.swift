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
        
        let data = readLocalFile(file: medicine.name)
        guard let data = data else {
            return
        }
        
        let medicineData = parse(data: data)
        guard let medicineData = medicineData else {
            return
        }
        
        nameLabel.text = medicineData.name
        concLabel.numberOfLines = 0
        concLabel.text = medicineData.concentration + "\n second line test"
        concLabel.sizeToFit()
        
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
