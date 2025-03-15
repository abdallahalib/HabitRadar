//
//  YearlyView.swift
//  HabitRadar
//
//  Created by Abdallah Ali on 15/03/2025.
//

import SwiftUI

struct YearlyView: View {
    @ObservedObject var viewModel: HabitViewModel
    let columns = Array(repeating: GridItem(.flexible(), spacing: 1), count: 30)
    let year = Date.now.year
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
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
                            
                            Spacer()
                            
                            Text("🔥 \(habit.streak) Days")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                        
                        LazyVGrid(columns: columns, spacing: 2) {
                            ForEach(year, id: \.self) { date in
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(habit.isCompleted(on: date) ? habit.color : habit.color.opacity(0.2))
                                    .frame(width: 8, height: 8)
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
    YearlyView(viewModel: HabitViewModel())
}
