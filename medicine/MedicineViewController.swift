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
    @IBOutlet var routesLabel: UILabel!
    @IBOutlet var indicationsLabel: UILabel!
    @IBOutlet var contraindicationsLabel: UILabel!
    @IBOutlet var notesLabel: UILabel!
    
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
        bulletPointList(medicineData.dose.adults, label: adultDosageLabel, titleString: "Adult Dosages")
        // peds dosages label
        bulletPointList(medicineData.dose.peds, label: pedsDosageLabel, titleString: "Peds Dosages")
        // routes label
        bulletPointList(medicineData.routes, label: routesLabel, titleString: "Routes")
        // indications label
        bulletPointList(medicineData.indications, label: indicationsLabel, titleString: "Indications")
        // contraindications label
        bulletPointList(medicineData.contraindications, label: contraindicationsLabel, titleString: "Contraindications")
        // notes/side effects label
        bulletPointList(medicineData.notes, label: notesLabel, titleString: "Notes/side effects")
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
    
    func bulletPointList(_ lst: [String], label: UILabel, titleString: String) {
        if (lst.count > 0) {
            let boldAttrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
            let doseText = NSMutableAttributedString(string: titleString, attributes: boldAttrs)
            
            for item in lst {
                doseText.append(NSMutableAttributedString(string: "\n\u{2022} " + item))
            }
            
            label.attributedText = doseText
        } else {
            label.text = ""
        }
    }
}
