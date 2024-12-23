//
//  LettersPage.swift
//  BayanApp
//
//  Created by Wafa Awad  on 19/12/2024.
//

import SwiftUI
import AVFoundation

struct LettersView: View {
    let lightGreen = Color(red: 0.94, green: 0.98, blue: 0.92)
    @State private var letterColor: Color = Color("letterGreen")

    // Corrected array with three elements: imageName, label, and optional destination
    let buttonData: [(imageName: String, label: String, destination: AnyView?)] = [
        (imageName: "camelButton", label: "Camel", destination:nil),
        (imageName: "FoxButtton", label: "Fox", destination: nil), // No destination
        (imageName: "GazelleButton", label: "Gazelle", destination: AnyView(Reindeer())),
        (imageName: "kangrooButton", label: "Kangaroo", destination: AnyView(Kangaroo())),
        (imageName: "LionButton", label: "Lion", destination: nil), // No destination
        (imageName: "TurtleButton", label: "Turtle", destination: AnyView(Turtle())),
        (imageName: "RacconButton", label: "Raccoon", destination: AnyView(Koala())),
        (imageName: "SheepButton", label: "Sheep", destination: nil) // No destination
    ]
    
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Top Section
                ZStack(alignment: .leading) {
                    lightGreen // Background color
                    
                    HStack(spacing: 20) {
                        // Avatar Image
                        Image("happyboy") // Replace with your image asset name
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100) // Avatar size
                            .clipShape(Circle())
                            .background(
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 120, height: 120)
                            )
                            .padding(.leading, 20) // Left padding for alignment
                    }
                    .padding(.top, 10) // Vertical spacing for better appearance
                }
                .frame(height: 150) // Top section height
                
                // Buttons Section
                ZStack {
                    Color(UIColor.systemBackground)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 20) {
                        Text("Choose an Animal")
                            .font(.title)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(lightGreen)
                                .frame(width: 780, height: 800)
                            
                            // LazyVGrid for Two Columns
                            LazyVGrid(
                                columns: [
                                    GridItem(.flexible(), spacing: 20),
                                    GridItem(.flexible(), spacing: 20),
                                ],
                                spacing: 20
                            ) {
                                ForEach(buttonData, id: \.imageName) { data in
                                    if let destination = data.destination {
                                        NavigationLink(destination: destination) {
                                            VStack {
                                                Image(data.imageName) // Replace with your actual image asset names
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 200, height: 200)
                                                    .clipShape(Circle()) // Ensures the button matches the image shape
                                                    .shadow(radius: 5)
                                            }
                                        }
                                    } else {
                                        Button(action: {
                                            // Show alert if no destination
                                            alertMessage = "\(data.label) page is under construction."
                                            showAlert = true
                                        }) {
                                            VStack {
                                                Image(data.imageName)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 200, height: 200)
                                                    .clipShape(Circle())
                                                    .shadow(radius: 5)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .edgesIgnoringSafeArea(.top)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Notice"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct LettersView_Previews: PreviewProvider {
    static var previews: some View {
        LettersView()
    }
}

