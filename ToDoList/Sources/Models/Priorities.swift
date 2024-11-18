//
//  Priorities.swift
//  ToDoList
//
//  Created by Julien Cotte on 18/10/2024.
//

import SwiftUI

enum Priorities: String, CaseIterable, Codable {
    case low = "Faible"
    case medium = "Medium"
    case high = "Haute"
    
    var color: Color {
        switch self {
        case .low : return .green
        case .medium : return .yellow
        case .high: return .red
        }
    }
}
