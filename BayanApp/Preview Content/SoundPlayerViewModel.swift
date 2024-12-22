//
//  SoundPlayerViewModel.swift
//  BayanApp
//
//  Created by Wafa Awad  on 22/12/2024.
//

import AVFoundation
import SwiftUI

class SoundPlayerViewModel: ObservableObject {
    @Published var isMuted = false
    private var audioPlayer: AVAudioPlayer?

    // Add the soundAssetName parameter in the initializer
    init(soundAssetName: String) {
        loadSound(named: soundAssetName)
    }

    // Function to load and play sound
    func loadSound(named soundName: String) {
        if let soundData = NSDataAsset(name: soundName)?.data {
            do {
                audioPlayer = try AVAudioPlayer(data: soundData)
                audioPlayer?.numberOfLoops = -1 // Loop indefinitely
            } catch {
                print("Error loading or playing sound: \(error)")
            }
        }
    }

    func playSound() {
        print("Playing sound")
        audioPlayer?.play()
    }

    func pauseSound() {
        print("Pausing sound")
        audioPlayer?.pause()
    }

    func resumeSound() {
        print("Resuming sound")
        audioPlayer?.play()
    }

}

