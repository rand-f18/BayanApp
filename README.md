# Arabic Letter Pronunciation App

This SwiftUI application helps users learn and pronounce Arabic letters correctly. It uses **AVFoundation** and **Speech framework** to analyze user pronunciation and provide real-time feedback.

## 🚀 Features
- 🎙 **Speech Recognition:** Users can record their pronunciation, and the app will analyze if they correctly pronounced the letter.
- 🖼 **Interactive UI:** A visually appealing design with images and buttons for each letter.
- 🔊 **Audio Recording & Analysis:** Uses Apple's **AVFoundation** and **Speech Framework** to recognize Arabic letters.
- 📖 **Learning & Training Guide:** Each letter includes a description of how to pronounce it properly.


## 📜 Installation
1. **Clone the Repository**  
   ```sh
   git clone https://github.com/yourusername/arabic-pronunciation-app.git

2. **Open in Xcode**
Navigate to the project folder and open ArabicPronunciationApp.xcodeproj.
Enable Speech Recognition
Go to Project Settings > Signing & Capabilities
Add Microphone Usage and Speech Recognition permissions in Info.plist:
<key>NSSpeechRecognitionUsageDescription</key>
<string>We need access to recognize your pronunciation.</string>
<key>NSMicrophoneUsageDescription</key>
<string>We need access to record your speech.</string>
3. **Run the App**
Select a simulator or a real device, then click ▶️ Run.
**🔧 Technologies Used**

SwiftUI - Declarative UI framework
AVFoundation - Audio recording
Speech Framework - Speech-to-text analysis
**📂 Project Structure**

📂 ArabicPronunciationApp
 ├── 📁 Models
 │   ├── LetterModel.swift
 ├── 📁 ViewModels
 │   ├── LettersViewModel.swift
 ├── 📁 Views
 │   ├── LettersView.swift
 │   ├── SinEvaluationContentView.swift
 │   ├── MapViewForKLetter.swift
 ├── 📁 Assets
 │   ├── Images (Letter buttons, pronunciation guide)
 ├── 📄 README.md
**🛠 Future Improvements**

🔄 Enhance Accuracy: Improve pronunciation analysis for better feedback.
📢 Voice Assistance: Add an AI-powered assistant for interactive learning.
🌍 More Letters & Exercises: Expand the library for a complete Arabic learning experience.
📜 License

This project is licensed under the MIT License.

**🤝 Contributing**

Contributions are welcome! Please submit a pull request or open an issue for suggestions.


**📩 Have Questions? Contact Me!**
📧 Email: Wafaalmutery7@gmail.com
🌐 GitHub: Wafa14161995



