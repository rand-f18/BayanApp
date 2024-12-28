import SwiftUI

struct LearningView: View {

    let onComplete: () -> Void
    let onBack: () -> Void
    let lightGreen = Color(red: 0.94, green: 0.98, blue: 0.92)
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
        VStack(spacing: 20) {
            // Header Section with Boy Image
            ZStack(alignment: .leading) {
                lightGreen
                HStack(spacing: 20) {
                    Image("Boy")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 150, maxHeight: 150)
                        .clipShape(Circle())
                        .background(Circle().fill(Color.green).frame(maxWidth: 180, maxHeight: 180))
                    Spacer()
                }
            }
            .padding(.bottom, 50)

            // Main Content Container
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(lightGreen)
                    .frame(maxWidth: 900, maxHeight: 800)
                    .padding()

                VStack {
                    // TabView for swipeable content
                    TabView {
                        // First Page: Letter and Sound Button
                        GeometryReader { geometry in
                            VStack {
                                Button(action: soundPlayerViewModel.toggleSound) {
                                    Image(systemName: soundPlayerViewModel.isMuted ? "speaker.slash.circle" : "speaker.wave.2.circle")
                                        .font(.system(size: 40))
                                        .padding()
                                        .background(Circle().fill(Color.white.opacity(0.8)))
                                        .foregroundColor(.green.opacity(0.6))
                                        .shadow(radius: 5)
                                }
                                .padding(.leading, 500)

                                Text(letter.letter)
                                    .font(.system(size: 120))
                                    .foregroundColor(.green)
                                    .padding()
                                    .frame(width: 160, height: 160)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center) // Center the content both vertically and horizontally
                        }
                        .tag(0)

                        // Second Page: Image and Description (Center the content)
                        GeometryReader { geometry in
                            VStack {
                                Image(letter.ImageProunounce) // Image centered
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)

                                Text(letter.descLearning)
                                    .font(.headline)
                                    .padding()
                                    .multilineTextAlignment(.center)
                                    .lineLimit(nil) // Ensures the text wraps properly without truncation
                                                                      
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center) // Center the content both vertically and horizontally
                        }
                        .tag(1)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .frame(maxHeight: 800) // Adjust this height for better space usage

                    .padding(.bottom, 40) // Add padding below TabView to create space

                    Spacer(minLength: 40) // Space between text and buttons              // Buttons Below the TabView
                    // Buttons Below the TabView
                    VStack {
                        Button("إكمال المستوى") {
                            onComplete()
                        }
                        .padding()
                        .frame(width: 200, height: 30)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)

                        Button("عودة") {
                            onBack()
                        }
                        .padding()
                        .frame(width: 200, height: 30)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .padding(.bottom, 10)

                    // Animal Image aligned to the left
                    HStack {
                        Image(letter.animel)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 160, height: 200)

                        Spacer() // Pushes the image to the left
                    }
                    .padding(.leading, 10) // Add padding to the left to ensure the image isn't too close to the edge
                }
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

