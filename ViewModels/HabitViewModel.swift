//
//  HabitViewModel.swift
//  HabitRadar
//
//  Created by Abdallah Ali on 15/03/2025.
//

import Foundation

import Foundation
import SwiftData

class HabitViewModel: ObservableObject {
    
    @Published var habits: [Habit] = [] {
        didSet {
            save()
        }
    }
    
    @Published var screen: Screen = .today
    
    @Published var date: Date = .now
    
    @Published var showSheet: Bool = false
    
    let key = "habits"
    
    init() {
        load()
    }
    
    func toggleCompletion(at index: Int) {
        habits[index].toggleCompletion()
    }
    
    func addHabit(name: String, icon: String, colorName: String) {
        let habit = Habit(name: name, icon: icon, colorName: colorName)
        habits.append(habit)
    }
    
    
    func save() {
        if let data = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func load() {
        if let data = UserDefaults.standard.data(forKey: key) {
            habits = try! JSONDecoder().decode([Habit].self, from: data)
        }
    }
}
