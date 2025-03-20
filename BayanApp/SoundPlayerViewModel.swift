import SwiftUI
import AVFoundation

class SoundPlayerViewModel: ObservableObject {
    @Published var isMuted: Bool = false
    private var audioPlayer: AVAudioPlayer?

    init(letter: LetterModel) {
        loadSound(named: letter.sound)
    }

    private func loadSound(named soundName: String) {
        guard let soundData = NSDataAsset(name: soundName)?.data else {
            print("Error: Sound asset \(soundName) not found.")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
        } catch {
            print("Error loading sound: \(error)")
        }
    }

    func toggleSound() {
        if isMuted {
            audioPlayer?.play()
        } else {
            audioPlayer?.pause()
        }
        isMuted.toggle()
    }

    func updateLetter(to newLetter: LetterModel) {
        loadSound(named: newLetter.sound)
        if !isMuted {
            audioPlayer?.play()
        }
    }

    deinit {
        audioPlayer?.stop()
    }
}

