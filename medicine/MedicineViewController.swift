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
    @IBOutlet var adultDosageLabel: UILabel!
    @IBOutlet var pedsDosageLabel: UILabel!
    
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
        
        // adult dosages label
        if (medicineData.dose.adults.count > 0) {
            let boldAttrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
            let doseText = NSMutableAttributedString(string: "Adult Dosages", attributes: boldAttrs)
            
            for dose in medicineData.dose.adults {
                doseText.append(NSMutableAttributedString(string: "\n\u{2022} " + dose))
            }
            
            adultDosageLabel.attributedText = doseText
        } else {
            adultDosageLabel.text = ""
        }
        
        // peds dosages label
        if (medicineData.dose.peds.count > 0) {
            let boldAttrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
            let doseText = NSMutableAttributedString(string: "Peds Dosages", attributes: boldAttrs)
            
            for dose in medicineData.dose.peds {
                doseText.append(NSMutableAttributedString(string: "\n\u{2022} " + dose))
            }
            
            pedsDosageLabel.attributedText = doseText
        } else {
            pedsDosageLabel.text = ""
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
