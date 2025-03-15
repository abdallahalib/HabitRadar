//
//  ContentView.swift
//  HabitRadar
//
//  Created by Abdallah Ali on 15/03/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HabitViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Tab view selector
                HStack {
                    ForEach(Screen.allCases, id: \.self) { screen in
                        Text(screen.rawValue)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(content: {
                                Capsule().fill(viewModel.screen == screen ? Color.green.opacity(0.2) : Color.clear)
                            })
                            .cornerRadius(8)
                            .onTapGesture {
                                withAnimation {
                                    viewModel.screen = screen
                                }
                            }
                    }
                }
                .padding()
                
                // Content based on selected view
                switch viewModel.screen {
                case .today:
                    TodayView(viewModel: viewModel)
                case .weekly:
                    WeeklyView(viewModel: viewModel)
                case .monthly:
                    MonthlyView(viewModel: viewModel)
                case .yearly:
                    YearlyView(viewModel: viewModel)
                }
            }
            .navigationTitle("Habit Radar")
            .navigationBarItems(trailing: Button("Add") {
                viewModel.showSheet = true
            })
            .sheet(isPresented: $viewModel.showSheet) {
                NavigationStack {
                    AddHabit(viewModel: viewModel)
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
