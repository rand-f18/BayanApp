
import SwiftUI

struct LearningView: View {
    // MARK: - Properties
    let onComplete: () -> Void
    let onBack: () -> Void
    let lightGreen = Color(red: 0 / 255, green: 110 / 255, blue: 127 / 255)

    @Binding var letter: LettterModel
    @StateObject private var soundPlayerViewModel: SoundPlayerViewModel
    @State private var selectedTab = 0 // Track the current tab
    @Environment(\.dismiss) private var dismiss  // To dismiss the current view
       
    // Custom initializer
    init(letter: Binding<LettterModel>, onComplete: @escaping () -> Void, onBack: @escaping () -> Void) {
        _letter = letter
        _soundPlayerViewModel = StateObject(wrappedValue: SoundPlayerViewModel(letter: letter.wrappedValue))
        self.onComplete = onComplete
        self.onBack = onBack
    }

    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                // Background container
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(.secondary.opacity(0.1))
                    .padding()

                VStack(spacing: 20) {
                    // MARK: TabView Section
                    TabView(selection: $selectedTab) {
                        // Page 1: Letter and Sound Button
                        VStack(spacing: 20) {
                            HStack{
                                Spacer()
                                Button(action: soundPlayerViewModel.toggleSound) {
                                    Image(systemName: soundPlayerViewModel.isMuted ? "speaker.slash.circle" : "speaker.wave.2.circle")
                                        .font(.system(size: 30))
                                        .padding()
                                        .background(Circle().fill(Color.white.opacity(0.8)))
                                        .foregroundColor(lightGreen)
                                        .shadow(radius: 5)
                                }
                                .padding(.trailing, UIScreen.main.bounds.width * 0.1)
                                
                            }
                            Image(letter.buttonImage)
                                .resizable()
                                .scaledToFit()
                                .frame(
                                    width: UIScreen.main.bounds.width * 0.5,
                                    height: UIScreen.main.bounds.width * 0.5
                                )
                                .cornerRadius(10)
                        }
                        .tag(0)
                        
                        // Page 2: Pronunciation Image and Description
                        VStack(spacing: 20) {
                            Image(letter.ImageProunounce)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 200, maxHeight: 200)
                            
                            Text(letter.descLearning)
                                .font(.headline)
                                .padding()
                                .multilineTextAlignment(.center)
                        }
                        .tag(1)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Hide the default dots indicator
                    
                    // Custom page indicator (dots)
                    HStack {
                        ForEach(0..<2, id: \.self) { index in
                            Circle()
                                .fill(index == selectedTab ? lightGreen : Color.gray)
                                .frame(width: 10, height: 10)
                                .padding(5)
                        }
                    }
                    
                    Spacer(minLength: 20)
                    
                    // Buttons Section
                    HStack(spacing: 20) {
                        Button("إكمال المستوى") {
                            onComplete()
                        }
                        .buttonStyle(CustomButtonStyle(backgroundColor: lightGreen))
                    }
                }
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitle("Letters", displayMode: .inline)  // Optional: Set the title for the navigation bar
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        CustomBackButton(onBack: {
                            onBack()  // Call the passed closure first
                            dismiss()  // Dismiss the current view (go back)
                        })
                    }
                }
    }
}

