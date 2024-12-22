//
//  Top Section View.swift
//  BayanApp
//
//  Created by Wafa Awad  on 22/12/2024.
//// MARK: - TopSectionView
import SwiftUI

struct TopSectionView: View {
    @ObservedObject var viewModel: TopSectionViewModel
    
    let lightGreen = Color(red: 0.94, green: 0.98, blue: 0.92)
    
    var body: some View {
        ZStack(alignment: .leading) {
            lightGreen
            HStack(spacing: 20) {
                // Avatar Image
                Image(viewModel.avatarImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .background(
                        Circle()
                            .fill(Color.green)
                            .frame(width: 120, height: 120)
                    )
                    .padding(.leading, 20)
                
                Spacer()
                
                // Speech Emoji Button
                Button(action: viewModel.toggleSound) {
                    Image(systemName: viewModel.isMuted ? "speaker.slash.circle" : "speaker.wave.2.circle")
                        .font(.system(size: 40))
                        .padding()
                        .background(Circle().fill(Color.white.opacity(0.8)))
                        .foregroundColor(.green.opacity(0.6)) // Set the icon color to green
                            .shadow(radius: 5)
                }
                .padding(.trailing, 20)
            }
            .padding(.top, 10)
        }
        .frame(height: 150)
    }
}
