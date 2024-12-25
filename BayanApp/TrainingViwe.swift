//
//  File 2.swift
//  TestLearning
//
//  Created by Wafa Awad  on 25/12/2024.
//


     // Header Section
            
import Foundation

import SwiftUI


struct TrainingView: View {
    let onComplete: () -> Void
    let onBack: () -> Void
    let lightGreen = Color(red: 0.94, green: 0.98, blue: 0.92)
    @State private var width: CGFloat = 150
    @State private var height: CGFloat = 150
    @Binding var letter: LettterModel
    @StateObject private var soundPlayerViewModel: SoundPlayerViewModel

    // Custom initializer
    init(letter: Binding<LettterModel>, onComplete: @escaping () -> Void, onBack: @escaping () -> Void) {
        _letter = letter
        _soundPlayerViewModel = StateObject(wrappedValue: SoundPlayerViewModel(letter: letter.wrappedValue))
        self.onComplete = onComplete
        self.onBack = onBack
    }

    var body: some View {
        VStack {
            // Header Section
            ZStack(alignment: .leading) {
                lightGreen
                HStack(spacing: 20) {
                    Image("Boy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: width, height: height)
                        .clipShape(Circle())
                        .background(
                            Circle()
                                .fill(Color.green)
                                .frame(width: 180, height: 180)
                        )
                        .padding(.leading, 50)
                    
                    Text("name")
                        .font(.title)
                        .fontWeight(.bold)
                }
                
            }
            .padding(.bottom, 20)
            .edgesIgnoringSafeArea(.all)
            
            Spacer()
            VStack{
                Text(letter.descrTraining)
                    .font(.title)
                    .fontWeight(.bold)
                    
            }

            // Adjust height if necessary
            Image(letter.animel)
            Spacer()
        }
        Button("إكمال المستوى") {
            onComplete()
        }
        .padding()
        .frame(width: 200, height: 60)
        .background(Color.green)
        .foregroundColor(.white)
        .cornerRadius(12)

        Button("عودة") {
            onBack()
        }
        .padding()
        .frame(width: 200, height: 60)
        .background(Color.gray)
        .foregroundColor(.white)
        .cornerRadius(12)
    }
}

