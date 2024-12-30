import SwiftUI
import AVFoundation

class SoundPlayerViewModel: ObservableObject {
    @Published var isMuted: Bool = false
    private var audioPlayer: AVAudioPlayer?
    private var currentLetter: LettterModel

    init(letter: LettterModel) {
        self.currentLetter = letter
        loadSound(named: letter.sound)
    }

    private func loadSound(named soundName: String) {
        guard let soundData = NSDataAsset(name: soundName)?.data else {
            print("Error: Sound asset \(soundName) not found.")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer?.numberOfLoops = -1 // Loop indefinitely
            audioPlayer?.prepareToPlay()
            audioPlayer?.play() // Start playing sound immediately after loading
        } catch {
            print("Error loading or playing sound: \(error)")
        }
    }

    func toggleSound() {
        if isMuted {
            audioPlayer?.play() // Play if muted
        } else {
            audioPlayer?.pause() // Pause if playing
        }
        isMuted.toggle()
    }

    func updateLetter(to newLetter: LettterModel) {
        self.currentLetter = newLetter
        loadSound(named: newLetter.sound)
        if !isMuted {
            audioPlayer?.play()
        }
    }

    deinit {
        audioPlayer?.stop()
    }
}

