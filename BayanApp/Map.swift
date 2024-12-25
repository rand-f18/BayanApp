//
//  Map.swift
//  TestLearning
//
//  Created by Wafa Awad  on 25/12/2024.
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
    @Binding var letter : LettterModel

    var body: some View {
     
        VStack(spacing: 30) {
            switch currentView {
            case .map:
                VStack(spacing: 30) {
                    Button(action: { currentView = .learn }) {
                        LevelButton(label: "تعلم", color: .green, icon: "sparkles")
                    }
                    if isTrainUnlocked {
                        Button(action: { currentView = .train }) {
                            LevelButton(label: "تدرب", color: .blue, icon: "puzzlepiece.fill")
                        }
                    } else {
                        LockedButton(label: "تدرب", color: .gray)
                    }
                    if isLaunchUnlocked {
                        Button(action: { currentView = .launch }) {
                            LevelButton(label: "انطلق", color: .orange, icon: "rocket.fill")
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
                VStack {
                    Text("مرحبا بك في مستوى انطلق!")
                        .font(.largeTitle)
                        .padding()
                    
                    Button("عودة") {
                        currentView = .map
                    }
                    .padding()
                    .frame(width: 200, height: 60)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
            }
        }
        .padding()
    }
    // Define view types for navigation
    enum ViewType {
        case map
        case learn
        case train
        case launch
    }

}
