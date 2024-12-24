//
//  MapView.swift
//  BayanApp
//
//  Created by Wafa Awad  on 24/12/2024.
//

//
//  map.swift
//  BayanApp
//
//  Created by Wafa Awad  on 23/12/2024.
//
import SwiftUI
struct MapViewForKLetter: View {
    @State private var isTrainUnlocked = false // "تدرب" is locked initially
     @State private var isLaunchUnlocked = false // "انطلق" is locked initially
        var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                NavigationLink(destination: LearnView(isTrainUnlocked: $isTrainUnlocked)) {
                                   LevelButton(label: "تعلم", color: .green, icon: "sparkles")
                               }
                               
                               // "تدرب" Button (Disabled until "تعلم" is completed)
                if isTrainUnlocked {
                    NavigationLink(destination: TrainView(isLaunchUnlocked: $isLaunchUnlocked)) {
                        LevelButton(label: "تدرب", color: .blue, icon: "puzzlepiece.fill")
                    }
                } else {
                    LockedButton(label: "تدرب", color: .gray)
                }

                // "انطلق" Button (Disabled until "تدرب" is completed)
                                if isLaunchUnlocked {
                                    NavigationLink(destination: LaunchView()) {
                                        LevelButton(label: "انطلق", color: .orange, icon: "rocket.fill")
                                    }
                                } else {
                                    LockedButton(label: "انطلق", color: .gray)
                                }
            }
            .padding()
            .navigationTitle("اختر المستوى")
        }
    }
}

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

// "تعلم" View
struct LearnView: View {
    @Binding var isTrainUnlocked: Bool // This is the binding that controls whether "تدرب" is unlocked
    
    var body: some View {
        // Pass the binding to LetterKView
        LetterKView(isTrainUnlocked: $isTrainUnlocked)
    }
}

// "تدرب" View
struct TrainView: View {
    @Binding var isLaunchUnlocked: Bool
    
    var body: some View {
        VStack {
            Text("مرحبا بك في مستوى تدرب!")
                .font(.largeTitle)
                .padding()
            Button("إكمال المستوى") {
                isLaunchUnlocked = true
            }
            .padding()
            .frame(width: 200, height: 60)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
    }
}

// "انطلق" View
struct LaunchView: View {
    var body: some View {
        Text("مرحبا بك في مستوى انطلق!")
            .font(.largeTitle)
            .padding()
    }
}



#Preview{
    MapViewForKLetter()
}
    


