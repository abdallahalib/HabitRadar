//
//  WeeklyView.swift
//  HabitRadar
//
//  Created by Abdallah Ali on 15/03/2025.
//

import SwiftUI

struct WeeklyView: View {
    @ObservedObject var viewModel: HabitViewModel
    let week = Date.now.week
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(viewModel.habits) { habit in
                    VStack(spacing: 10) {
                        HStack {
                            Image(systemName: habit.icon)
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                .background(habit.color)
                                .clipShape(Circle())
                            
                            Text(habit.name)
                                .fontWeight(.medium)
                            
                            Spacer()
                            
                            Text("🔥 \(habit.streak) Days")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        HStack {
                            ForEach(week, id: \.self) { date in
                                VStack {
                                    Text(date.dayOfWeek)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    if habit.isCompleted(on: date) {
                                        ZStack {
                                            Circle()
                                                .fill(habit.color.opacity(0.2))
                                                .frame(width: 36, height: 36)
                                            
                                            Image(systemName: "checkmark")
                                                .foregroundColor(habit.color)
                                        }
                                    } else {
                                        Circle()
                                            .stroke(habit.color, lineWidth: 1)
                                            .frame(width: 36, height: 36)
                                    }
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                    }
                    .padding()
                    .background(habit.color.opacity(0.1))
                    .cornerRadius(12)
                }
            }
            .padding()
        }
    }
}

#Preview {
    WeeklyView(viewModel: HabitViewModel())
}
