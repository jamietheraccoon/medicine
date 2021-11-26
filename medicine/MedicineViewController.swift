//
//  PokemonViewController.swift
//  medicine
//
//  Created by jamie on 11/20/21.
//

import UIKit

class MedicineViewController : UIViewController {
    @IBOutlet var nameLabel: UILabel!
    
    var medicine: MedicineListEntry!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = medicine.name.capitalized
    }
}
