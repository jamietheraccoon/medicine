//
//  Medicine.swift
//  medicine
//
//  Created by jamie on 11/16/21.
//

import Foundation

// ----------------------------
// medicine.json

struct MedicineList: Decodable {
    let medicine: [MedicineListEntry]
}

struct MedicineListEntry: Decodable {
    let name: String
    let file: String
}
