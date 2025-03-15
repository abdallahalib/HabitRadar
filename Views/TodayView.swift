//
//  DailyView.swift
//  HabitRadar
//
//  Created by Abdallah Ali on 15/03/2025.
//

import SwiftUI

struct TodayView: View {
    @ObservedObject var viewModel: HabitViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.habits.indices, id: \.self) { index in
                    let habit = viewModel.habits[index]
                    HStack {
                            Image(systemName: habit.icon)
                                .foregroundColor(.white)
                                .frame(width: 36, height: 36)
                                .background(habit.color)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text(habit.name)
                                    .fontWeight(.medium)
                                
                                Text("🔥 \(habit.streak) Days")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.leading, 8)
                            
                            Spacer()
                            
                            if habit.isCompleted {
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
                        .padding()
                        .background(habit.color.opacity(0.1))
                        .cornerRadius(12)
                        .onTapGesture {
                            withAnimation {
                                viewModel.toggleCompletion(at: index)
                            }
                        }
                }
            }
            .padding()
        }
    }
}

#Preview {
    TodayView(viewModel: HabitViewModel())
}
