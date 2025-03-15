//
//  AddHabit.swift
//  HabitRadar
//
//  Created by Abdallah Ali on 16/03/2025.
//


import SwiftUI


struct AddHabit: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var habitName: String = ""
    @State private var selectedIcon: String = "figure.walk"
    @State private var selectedColor: String = "green"
    @State private var showAlert: Bool = false
    
    var viewModel: HabitViewModel
    
    let icons: [String] = [
        "figure.walk", "laptopcomputer", "figure.run", "book.fill",
        "figure.mind.and.body", "carrot.fill", "bed.double.fill",
        "dumbbell.fill", "drop.fill", "brain.head.profile", "heart.fill",
        "leaf.fill", "sun.max.fill", "pills.fill", "cup.and.saucer.fill"
    ]
    
    let colors: [(name: String, color: Color)] = [
        ("green", .green), ("blue", .blue), ("purple", .purple),
        ("orange", .orange), ("pink", .pink), ("brown", .brown)
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Habit name field
                Text("Habit Name")
                    .font(.headline)
                
                TextField("Type your habit here...", text: $habitName)
                    .padding()
                    .frame(height: 55)
                    .background(Color(.gray).opacity(0.1))
                    .cornerRadius(10)
                
                // Icon selection
                Text("Choose an Icon")
                    .font(.headline)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5), spacing: 15) {
                    ForEach(icons, id: \.self) { icon in
                        Button(action: {
                            withAnimation {
                                selectedIcon = icon
                            }
                        }) {
                            Image(systemName: icon)
                                .font(.title2)
                                .frame(width: 50, height: 50)
                                .background(selectedIcon == icon ? Color.fromString(selectedColor).opacity(0.2) : Color(.gray).opacity(0.1))
                                .foregroundColor(selectedIcon == icon ?
                                                 Color.fromString(selectedColor) : .primary)
                                .cornerRadius(10)
                        }
                    }
                }
                
                // Color selection
                Text("Choose a Color")
                    .font(.headline)
                    .padding(.top, 5)
                
                HStack(spacing: 15) {
                    ForEach(colors, id: \.name) { color in
                        Button(action: {
                            withAnimation {
                                selectedColor = color.name
                            }
                        }) {
                            Circle()
                                .fill(color.color)
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: selectedColor == color.name ? 3 : 0)
                                )
                                .shadow(color: selectedColor == color.name ?
                                    Color.black.opacity(0.1) : Color.clear, radius: 3)
                        }
                    }
                }
                
                
                // Save button
                Button(action: {
                    saveHabit()
                }) {
                    Text("SAVE")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(validateInput() ? Color.fromString(selectedColor) : Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.top)
                }
                .disabled(!validateInput())
            }
            .padding()
        }
        .navigationTitle("Add Habit 🚀")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Success"),
                message: Text("Habit added successfully!"),
                dismissButton: .default(Text("OK")) {
                    dismiss()
                }
            )
        }
    }

    
    private func validateInput() -> Bool {
        return !habitName.isEmpty
    }
    
    private func saveHabit() {
        viewModel.addHabit(name: habitName, icon: selectedIcon, colorName: selectedColor)
        showAlert = true
    }
}

#Preview {
    AddHabit(viewModel: HabitViewModel())
}
