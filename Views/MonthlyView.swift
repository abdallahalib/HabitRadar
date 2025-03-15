//
//  MonthlyView.swift
//  HabitRadar
//
//  Created by Abdallah Ali on 15/03/2025.
//

import SwiftUI

struct MonthlyView: View {
    @ObservedObject var viewModel: HabitViewModel
    let columns = Array(repeating: GridItem(.flexible(), spacing: 1), count: 7)
    let month = Date.now.month
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(viewModel.habits) { habit in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: habit.icon)
                                .foregroundColor(.white)
                                .frame(width: 24, height: 24)
                                .background(habit.color)
                                .clipShape(Circle())
                            
                            Text(habit.name)
                                .font(.footnote)
                                .fontWeight(.medium)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            
                            Spacer()
                            
                            Text("🔥 \(habit.streak) Days")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                        
                        LazyVGrid(columns: columns, spacing: 4) {
                            ForEach(month, id: \.self) { date in
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(habit.isCompleted(on: date) ? habit.color : habit.color.opacity(0.2))
                                    .frame(width: 16, height: 16)
                            }
                        }
                    }
                    .padding(12)
                    .background(habit.color.opacity(0.1))
                    .cornerRadius(12)
                }
            }
            .padding()
        }
    }
}

#Preview {
    MonthlyView(viewModel: HabitViewModel())
}
