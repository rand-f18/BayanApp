//
//  TopSectionViewModel.swift
//  BayanApp
//
//  Created by Wafa Awad  on 22/12/2024.
//

import SwiftUI
import AVFoundation

class TopSectionViewModel: ObservableObject {
    @Published var isMuted = false
    @Published var avatarImage: String = "happyboy" // Default avatar image
    
    // Toggle mute/unmute
    func toggleSound() {
        isMuted.toggle()
    }
}
