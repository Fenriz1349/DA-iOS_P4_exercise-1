//
//  Status.swift
//  ToDoList
//
//  Created by Julien Cotte on 18/10/2024.
//

import Foundation

// Enum pour gérer tous les cas de complétions et les filtrer.
enum Status: String, CaseIterable {
    case all = "Tout"
    case done = "Fait"
    case undone = "À Faire"
}
