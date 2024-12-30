import SwiftUI
import AVFoundation
import Speech

import SwiftUI

struct SinEvaluationContentView: View {
    @StateObject private var audioRecorder = SinAudioRecorder()
    let lightGreen = Color(red: 0 / 255, green: 110 / 255, blue: 127 / 255)

    var body: some View {
        VStack(spacing: 20) {
            // Title at the top
            Text("تقييم نطق حرف السين")
                .font(.largeTitle)
                .foregroundColor(lightGreen)
                .fontWeight(.bold)
                .padding(.top, 20)

            // Instruction for the user
            Text("حاول نطق حرف السين")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()

            // Feedback message
            if !audioRecorder.feedbackMessage.isEmpty {
                Text(audioRecorder.feedbackMessage)
                    .font(.headline)
                    .padding()
            }

            // Dynamic image
            Image("Seevaulation")
                .resizable()
                .scaledToFit() // Scales the image while maintaining aspect ratio
                .frame(
                    maxWidth: 600, // Maximum width for the image
                        maxHeight: 550 // Maximum height for the image
                                )
                        
                                .padding()
                                .animation(.easeInOut(duration: 0.5), value: audioRecorder.isPassed)


            // Mic button
            Button(action: {
                if audioRecorder.isRecording {
                    audioRecorder.stopRecording()
                } else {
                    audioRecorder.startRecording()
                }
            }) {
                Image(systemName: "mic.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                    .foregroundColor(audioRecorder.isRecording ? .red : .black)
                    .padding(.bottom, 20)

            }

            // Additional instruction
            Text("تأكد من نطق حرف السين بوضوح.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground))
    }
}

class SinAudioRecorder: NSObject, AVAudioRecorderDelegate, ObservableObject {
    @Published var feedbackMessage = ""
    @Published var isPassed = false
    @Published var isRecording = false
    let targetLetter = "س"
    private var audioRecorder: AVAudioRecorder?

    func startRecording() {
        isRecording = true
        feedbackMessage = "جاري التسجيل..."

        configureAudioSession { success in
            if success {
                let audioFilename = self.getDocumentsDirectory().appendingPathComponent("recording.m4a")
                let settings = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 12000,
                    AVNumberOfChannelsKey: 1,
                    AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                ]
                
                do {
                    self.audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
                    self.audioRecorder?.delegate = self
                    self.audioRecorder?.record()
                } catch {
                    self.feedbackMessage = "فشل في التسجيل: \(error.localizedDescription)"
                    print("Error recording: \(error)")
                    self.isRecording = false
                }
            } else {
                self.feedbackMessage = "فشل في إعداد جلسة الصوت."
                self.isRecording = false
            }
        }
    }

    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
        feedbackMessage = "تم تسجيل الصوت."
        analyzeAudio()
    }

    func analyzeAudio() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        guard FileManager.default.fileExists(atPath: audioFilename.path) else {
            DispatchQueue.main.async {
                self.feedbackMessage = "فشل في العثور على ملف الصوت."
            }
            return
        }

        SFSpeechRecognizer.requestAuthorization { authStatus in
            guard authStatus == .authorized else {
                DispatchQueue.main.async {
                    self.feedbackMessage = "الرجاء منح الإذن للتعرف على الصوت."
                }
                return
            }
            
            let arabicRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ar-SA"))
            let request = SFSpeechURLRecognitionRequest(url: audioFilename)
            
            arabicRecognizer?.recognitionTask(with: request) { result, error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.feedbackMessage = "فشل في تحليل الصوت: \(error.localizedDescription)"
                    }
                    return
                }
                
                guard let result = result else {
                    DispatchQueue.main.async {
                        self.feedbackMessage = "فشل في تحليل الصوت: لا توجد نتيجة."
                    }
                    return
                }
                
                let spokenText = result.bestTranscription.formattedString
                
                DispatchQueue.main.async {
                    let cleanedText = spokenText
                        .replacingOccurrences(of: "\u{200E}", with: "")
                        .replacingOccurrences(of: "\u{200F}", with: "")
                        .trimmingCharacters(in: .whitespacesAndNewlines)

                    print("Cleaned recognized text: '\(cleanedText)'")
                    print("Comparing '\(cleanedText)' with '\(self.targetLetter)'")
                    
                    if cleanedText.contains(self.targetLetter) {
                        self.feedbackMessage = "نطق صحيح! 🎉"
                        self.isPassed = true
                        print("Matched! Background should turn green.")
                    } else {
                        self.feedbackMessage = "حاول مرة أخرى."
                        self.isPassed = false
                        print("Did not match. Background should remain gray.")
                    }
                }
            }
        }
    }
    
    func configureAudioSession(completion: @escaping (Bool) -> Void) {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try audioSession.setActive(true)
            completion(true)
        } catch {
            print("Failed to set up audio session: \(error)")
            completion(false)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

#Preview {
    SinEvaluationContentView()
}
