//
//  Extensions.swift
//  HabitRadar
//
//  Created by Abdallah Ali on 15/03/2025.
//

import Foundation
import SwiftUI

extension Date {
    var dayOfWeek: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: self)
    }
    
    var month: [Date] {
        let calendar = Calendar.current
        // Get the first day of the month
        let components = calendar.dateComponents([.year, .month], from: self)
        guard let first = calendar.date(from: components),
                let range = calendar.range(of: .day, in: .month, for: self) else {
            return []
        }
        return range.map { day in
            calendar.date(byAdding: .day, value: day - 1, to: first)!
        }
    }
    
    var year: [Date] {
        let calendar = Calendar.current
        // Get the first day of the year
        let components = calendar.dateComponents([.year], from: self)
        guard let first = calendar.date(from: components),
              let range = calendar.range(of: .day, in: .year, for: self) else {
            return []
        }
        return range.map { day in
            calendar.date(byAdding: .day, value: day - 1, to: first)!
        }
    }
    
    var week: [Date] {
        let calendar = Calendar.current
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: self)?.start
        guard let firstDayOfWeek = startOfWeek else { return [] }
        return (0..<7).map { day in
            calendar.date(byAdding: .day, value: day, to: firstDayOfWeek)!
        }
    }
}

extension Color {
    static func fromString(_ input: String) -> Color {
        switch input {
        case "green": return .green
        case "blue": return .blue
        case "purple": return .purple
        case "orange": return .orange
        case "pink": return .pink
        case "brown": return .brown
        case "yellow": return .yellow
        case "red": return .red
        case "gray": return .gray
        case "black": return .black
        case "white": return .white
        default: return .primary
            
        }
    }
}
