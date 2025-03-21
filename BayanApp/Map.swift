//
//  Map.swift
//  TestLearning
//
//  Created by Wafa Awad on 25/12/2024.
//

import SwiftUI

// A reusable button view for levels
struct LevelButton: View {
    var label: String
    var color: Color
    var icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.title2)
            Text(label)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(width: 200, height: 60)
        .background(color)
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

// Locked button view for locked levels
struct LockedButton: View {
    var label: String
    var color: Color
    
    var body: some View {
        HStack {
            Image(systemName: "lock.fill")
                .foregroundColor(.white)
                .font(.title2)
            Text(label)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(width: 200, height: 60)
        .background(color)
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

struct MapViewForKLetter: View {
    @State private var currentView: ViewType = .map
    @State private var isTrainUnlocked = false // "تدرب" is locked initially
    @State private var isLaunchUnlocked = false // "انطلق" is locked initially
    @ObservedObject var object = LettersViewModel()
    @Binding var letter: LetterModel

    let customYellow = Color(red: 248/255, green: 203/255, blue: 46/255)
    let customOrangeRed = Color(red: 238/255, green: 80/255, blue: 7/255)
    let customDarkRed = Color(red: 178/255, green: 39/255, blue: 39/255)
    let lightGreen = Color(red: 0/255, green: 110/255, blue: 127/255)

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 30) {
            ZStack {
                // Background container
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(.secondary.opacity(0.1))
                    .padding()
                
                switch currentView {
                case .map:
                    VStack(spacing: 30) {
                        Button(action: { currentView = .learn }) {
                            LevelButton(label: "تعلم", color: customYellow, icon: "sparkles")
                        }
                        if isTrainUnlocked {
                            Button(action: { currentView = .train }) {
                                LevelButton(label: "تدرب", color: customOrangeRed, icon: "puzzlepiece.fill")
                            }
                        } else {
                            LockedButton(label: "تدرب", color: .gray)
                        }
                        if isLaunchUnlocked {
                            Button(action: { currentView = .launch }) {
                                LevelButton(label: "انطلق", color: customDarkRed, icon: "rocket.fill")
                            }
                        } else {
                            LockedButton(label: "انطلق", color: .gray)
                        }
                    }
                case .learn:
                    LearningView(
                        letter: $letter,
                        onComplete: {
                            isTrainUnlocked = true
                            currentView = .map
                        },
                        onBack: {
                            currentView = .map
                        }
                    )
                case .train:
                    TrainingView(
                        letter: $letter,
                        onComplete: {
                            isLaunchUnlocked = true
                            currentView = .map
                        },
                        onBack: {
                            currentView = .map
                        }
                    )
                case .launch:
                    determineLaunchDestination(for: letter)
                }
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true) // Hide the default back button
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton(onBack: {
                    presentationMode.wrappedValue.dismiss() // Pop the view
                }, iconColor: lightGreen)
            }
        }
    }
    
    @ViewBuilder
    private func determineLaunchDestination(for letter: LetterModel) -> some View {
        switch letter.letter {
        case "ر":
            EvaluationContentView()
        case "س":
            SinEvaluationContentView()
        case "ج":
            GEvaluationContentView()
        case "ث":
            ThEvaluationContentView()
        case "غ":
            GhEvaluationContentView()
        case "خ":
            KhEvaluationContentView()
        case "ك":
            KEvaluationContentView()
        case "ش":
            ShEvaluationContentView()
        default:
            Text("Invalid letter selected for Launch.")
        }
    }

    // Define view types for navigation
    enum ViewType {
        case map, learn, train, launch
    }
}

