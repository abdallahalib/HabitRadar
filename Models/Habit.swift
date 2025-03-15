//
//  Habit.swift
//  HabitRadar
//
//  Created by Abdallah Ali on 15/03/2025.
//

import SwiftUI
import SwiftData
import Foundation

struct Habit: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var icon: String
    var colorName: String
    var streak: Int = 0
    var completions: [Date] = []
    
    var isCompleted: Bool {
        guard let last = completions.last else {
            return false
        }
        return Calendar.current.isDateInToday(last)
    }
    
    var isYesterday: Bool {
        guard let last = completions.last else {
            return false
        }
        return Calendar.current.isDateInYesterday(last)
    }
    
    var color: Color {
        return .fromString(colorName)
    }
    
    
    mutating private func complete() {
        if isYesterday {
            streak += 1
        } else {
            streak = 1
        }
        completions.append(.now)
    }
    
    mutating func toggleCompletion() {
        if isCompleted {
            streak -= 1
            completions.removeLast()
        } else {
            complete()
        }
    }
        
        
    func isCompleted(on date: Date) -> Bool {
        completions.contains { completion in
            Calendar.current.isDate(completion, inSameDayAs: date)
        }
    }
    
}
