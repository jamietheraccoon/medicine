//
//  Medicine.swift
//  medicine
//
//  Created by jamie on 11/16/21.
//

import Foundation

// ----------------------------
// medicine.json

struct MedicineList: Codable {
    let medicine: [Medicine]
}

struct Medicine: Codable {
    let name: String
    let file: String
}
