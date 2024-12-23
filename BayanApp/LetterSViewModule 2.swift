//
//  LetterSView.swift
//  BayanApp
//
//  Created by Wafa Awad  on 19/12/2024.
//



import SwiftUI

struct LetterSView: View {
    @StateObject private var viewModel = SoundPlayerViewModel(soundAssetName: "Sletter")
    @StateObject private var topSectionViewModel = TopSectionViewModel()
    let lightGreen = Color(red: 0.94, green: 0.98, blue: 0.92)
    @State private var currentImageIndex = 0
    let imageNames = ["", "GProunounce"]
    @State private var currentAnimal = Animal(name: "turtle") // Default animal
    @State private var xOffset: CGFloat = -390 // Control horizontal position
       @State private var yOffset: CGFloat = 200 // Control vertical position

    var body: some View {
        VStack(spacing: 0) {
            // Top Section
            TopSectionView(viewModel: topSectionViewModel)
            
            // Main Content
            ZStack {
                Color(UIColor.systemBackground)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(lightGreen)
                            .frame(maxWidth: 900, maxHeight: 800)
                            .padding()
                        
                        // TabView for swiping
                       TabView(selection: $currentImageIndex) {
                        // First Image/Content
                            VStack {
                                    Text("س")
                                        .font(.system(size: 120))
                                        .foregroundColor(.green)
                                        .padding()
                                        .frame(width: 160, height: 160)
                                        .background(Color.white)
                                        .clipShape(Circle())
                                        .shadow(radius: 5)
                                // Display Animal Image (Gazelle or any other)
                                AnimalImageView(animal: currentAnimal, xOffset: xOffset, yOffset: yOffset)
                                    }
                           
                                    .tag(0) // Tag for the first image
                                                    
              // Second Image/Content
                        VStack {
                            Text("تخرج الغين من أدنى الحلق ( أي أقربه للسان) مع منطقة الحنك اللحمي و قبل")
                            .font(.system(size: 30))
                            Image(imageNames[currentImageIndex == 0 ? 1 : 1])
                            .resizable()
                            .scaledToFill()
                            .padding()
                            .frame(width: 260, height: 160)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            // Display Animal Image (Gazelle or any other)
                            AnimalImageView(animal: currentAnimal, xOffset: xOffset, yOffset: yOffset)
                            }
                            .tag(1) // Tag for the second image
                            }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always)) // Enable swipe functionality
                        
                                            }

                    // Dot Indicator: Shows current index
                    HStack {
                        ForEach(0..<imageNames.count, id: \.self) { index in
                            Circle()
                                .fill(currentImageIndex == index ? Color.orange : Color.gray)
                                .frame(width: 10, height: 10)
                                .padding(2)
                                .onTapGesture {
                                    // Change the image and pause the sound when the dot is clicked
                                    currentImageIndex = index
                                    // Pause the sound immediately when the image changes
                                   
                                }
                        }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
                .onAppear {
                    // Start sound automatically when the view appears if not muted
                    if !topSectionViewModel.isMuted {
                        viewModel.playSound()
                    }
                }
                .onDisappear {
                    // Pause the sound when the view disappears
                    viewModel.pauseSound()
                }
                .onChange(of: topSectionViewModel.isMuted) { newValue in
                    // Toggle sound based on mute state
                    if newValue {
                        viewModel.pauseSound()
                    } else {
                        viewModel.resumeSound()
                    }
        }
    }
}

#Preview {
    LetterSView()
}








/*Just in case
import SwiftUI
import AVFoundation

struct LetterSView: View {
    @StateObject private var viewModel = SoundPlayerViewModel() // ViewModel
    let lightGreen = Color(red: 0.94, green: 0.98, blue: 0.92)
    @State private var letterColor: Color = Color("letterGreen")

    var body: some View {
        VStack(spacing: 0) {
            // Top Section
            ZStack(alignment: .leading) {
                lightGreen // Background color
                
                HStack(spacing: 20) {
                    // Avatar Image
                    Image("happyboy") // Replace with your image asset name
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .background(
                            Circle()
                                .fill(Color.green)
                                .frame(width: 120, height: 120)
                        )
                        .padding(.leading, 20) // Left padding for alignment
                    
                    
                }
                .padding(.top, 10) // Vertical spacing
            }
            .frame(height: 150) // Top section height
            
            // Main Content
            ZStack {
                Color(UIColor.systemBackground)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    ZStack{
                        // Center rectangle
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(lightGreen)
                            .frame(width: 850, height: 950)
                            .overlay(
                                // Centered button inside the rectangle
                                Button(action: {
                                    viewModel.playSound(named: "Sletter")
                                }) {
                                    Text("س")
                                        .font(.system(size: 120))
                                        .foregroundColor(.green)
                                        .padding()
                                        .frame(width: 160, height: 160)
                                        .background(Color.white)
                                        .cornerRadius(80)
                                        .clipShape(Circle()) // Ensures the button matches the image shape
                                        .shadow(radius: 5)
                                }
                            )
                        
                        // Image positioned below the rectangle
                        GeometryReader { geometry in
                            Image(.turtle) // Ensure the image name matches your assets
                                .resizable()
                                .scaledToFit()
                                .frame(width: 400, height: 250) // Adjust the size of the image
                                .position(x: 150, y: geometry.size.height - 240) // Position image at left bottom corner
                        }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}


#Preview {
    LetterSView()
}

*/
