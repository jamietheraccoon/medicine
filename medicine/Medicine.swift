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

// ----------------------------
// individual medicine json files

struct MedicineData: Decodable {
    let name: String
    let concentration: String
    let routes: [String]
    
    struct Dosages: Decodable {
        let adults: [String]
        let peds: [String]
    }
    
    let indications: [String]
    let contraindications: [String]
    let notes: [String]
}
