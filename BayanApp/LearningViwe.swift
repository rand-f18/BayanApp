import SwiftUI

struct LearningView: View {
    let onComplete: () -> Void
    let onBack: () -> Void
    let lightGreen = Color(red: 0.94, green: 0.98, blue: 0.92)
    @State private var width: CGFloat = 150
    @State private var height: CGFloat = 150
    @Binding var letter: LettterModel
    @StateObject private var soundPlayerViewModel: SoundPlayerViewModel

    // Custom initializer
    init(letter: Binding<LettterModel>, onComplete: @escaping () -> Void, onBack: @escaping () -> Void) {
        _letter = letter
        _soundPlayerViewModel = StateObject(wrappedValue: SoundPlayerViewModel(letter: letter.wrappedValue))
        self.onComplete = onComplete
        self.onBack = onBack
    }

    var body: some View {
        VStack {
            // Header Section
            ZStack(alignment: .leading) {
                lightGreen
                HStack(spacing: 20) {
                    Image("Boy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: width, height: height)
                        .clipShape(Circle())
                        .background(
                            Circle()
                                .fill(Color.green)
                                .frame(width: 180, height: 180)
                        )
                        .padding(.leading, 50)
                    
                    Text("name")
                        .font(.title)
                        .fontWeight(.bold)
                }
                Button(action: soundPlayerViewModel.toggleSound) {
                    Image(systemName: soundPlayerViewModel.isMuted ? "speaker.slash.circle" : "speaker.wave.2.circle")
                        .font(.system(size: 40))
                        .padding()
                        .background(Circle().fill(Color.white.opacity(0.8)))
                        .foregroundColor(.green.opacity(0.6))
                        .shadow(radius: 5)
                }
                .padding(.trailing, 20)
            }
            .padding(.bottom, 20)
            .edgesIgnoringSafeArea(.all)
            
            Spacer()

            // Main Swipeable Content
            TabView {
                // First Page
                VStack {
                    Text(letter.letter)
                        .font(.system(size: 120))
                        .foregroundColor(.green)
                        .padding()
                        .frame(width: 160, height: 160)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                    
                   
                    Button("إكمال المستوى") {
                        onComplete()
                    }
                    .padding()
                    .frame(width: 200, height: 60)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)

                    Button("عودة") {
                        onBack()
                    }
                    .padding()
                    .frame(width: 200, height: 60)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .tag(0)

                // Second Page
                VStack {
                    Image(letter.ImageProunounce)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                            
//                    Image("AnimalImage") // Replace with the actual animal image asset name
//
                    Text(letter.descLearning)
                        .font(.headline)
                        .padding()
                        .multilineTextAlignment(.center)

                }
                .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always)) // Enables swipe functionality
            .frame(height: 400) // Adjust height if necessary
            Image(letter.animel)
            Spacer()
        }
    }
}

