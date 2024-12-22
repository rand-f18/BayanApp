//
//  Choose the character.swift
//  BayanApp
//
//  Created by Wafa Awad  on 22/12/2024.
//
import SwiftUI

struct PageTowView: View {
    let lightGreen = Color(red: 0.94, green: 0.98, blue: 0.92)
    @State private var name: String = ""
    @State private var selectedCharacter: Int? = nil
    
    // Corrected array with three elements: imageName, label, and optional destination
    let buttonData: [(imageName: String, label: String, destination: AnyView?)] = [
        (imageName: "Character1", label: "boyl", destination: AnyView(LettersView())),
        (imageName: "Character2", label: "boy2", destination: nil), // No destination
        (imageName: "Character3", label: "girl1", destination: nil),
        (imageName: "Character4", label: "girl2", destination: nil)
    ]
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack{  ZStack {
            Color(UIColor.systemBackground)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                VStack(spacing: 10) {
                    Text("مرحباً أيها البطل!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    Text("اكتب اسمك واختر شخصيتك\nواستعد لاكتشاف عالم مليء بالمرح والتعلم والتحديات")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 20)
                
                TextField("Name", text: $name)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
                
                ZStack{
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
                .padding()
                
                Spacer()
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Under Construction"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
         }
    }
}
#Preview {
    PageTowView()
}
