import SwiftUI
import AVFoundation
import Speech

struct ThEvaluationContentView: View {
    @StateObject private var audioRecorder = ThAudioRecorder()
    
    var body: some View {
        VStack {
            // Title at the very top
            Text("تقييم نطق حرف الثاء")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 50)
                .padding(.bottom, 50)

            // Instruction for the user
            Text("حاول نطق حرف الثاء")
                .font(.title)
                .padding()
            
            Text(audioRecorder.feedbackMessage)
                .font(.headline)
                .padding()
            
            // Display the target letter "ث" in a larger font
            Text("ث")
                .font(.system(size: 300))
                .frame(width: 500, height: 500)
                .background(audioRecorder.isPassed ? Color.green : Color.gray)
                .cornerRadius(10)
                .foregroundColor(.white)
                .animation(.easeInOut(duration: 0.5), value: audioRecorder.isPassed)

            // Mic icon button
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
                    .foregroundColor(audioRecorder.isRecording ? Color.red : Color.black)
                    .padding(.top, 100)
            }

            // User guidance
            Text("تأكد من نطق حرف الثاء بوضوح.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

class ThAudioRecorder: NSObject, AVAudioRecorderDelegate, ObservableObject {
    @Published var feedbackMessage = ""
    @Published var isPassed = false
    @Published var isRecording = false
    let targetLetter = "ث" // تغيير الحرف المستهدف إلى ثاء
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
        print("Audio file path: \(audioFilename)")
        
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
                        print("Recognition error: \(error)")
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
                print("Recognized text: \(spokenText)")
                
                DispatchQueue.main.async {
                    let cleanedText = spokenText
                        .replacingOccurrences(of: "\u{200E}", with: "")
                        .replacingOccurrences(of: "\u{200F}", with: "")
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    print("Cleaned recognized text: '\(cleanedText)'")
                    print("Comparing '\(cleanedText)' with '\(self.targetLetter)'")
                    
                    // Set isPassed based on whether the target letter is the only recognized character
                    if cleanedText == self.targetLetter {
                        self.feedbackMessage = "نطق صحيح! 🎉" // رسالة عند النطق الصحيح
                        self.isPassed = true // أخضر للنطق الصحيح
                        print("Matched! Background should turn green.")
                    } else {
                        self.feedbackMessage = "حاول مرة أخرى." // رسالة عند النطق غير الصحيح
                        self.isPassed = false // رمادي للنطق غير الصحيح
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
    ThEvaluationContentView()
}
