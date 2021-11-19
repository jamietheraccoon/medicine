//
//  Medicine.swift
//  medicine
//
//  Created by jamie on 11/16/21.
//

import Foundation

// ----------------------------
// medicine.json

struct MedicineList {
    let medicine: [Medicine]
}

struct Medicine {
    let name: String
    let file: String
}
