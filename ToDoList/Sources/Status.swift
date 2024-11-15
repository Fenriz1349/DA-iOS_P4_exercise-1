//
//  Status.swift
//  ToDoList
//
//  Created by Julien Cotte on 18/10/2024.
//

import Foundation

// Enum to handle all completion Cases
enum Status: String, CaseIterable {
    case all = "Tout"
    case done = "Fait"
    case undone = "À Faire"
}
