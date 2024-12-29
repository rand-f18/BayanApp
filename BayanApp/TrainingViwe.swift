import SwiftUI

struct TrainingView: View {
    let onComplete: () -> Void
    let onBack: () -> Void
    let lightGreen = Color(red: 0/255, green: 110/255, blue: 127/255 )
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
        VStack(spacing: 20) {
            // Header Section
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
                VStack{
                    GeometryReader { geometry in
                        VStack {
                            Spacer() // Push content downward
                            
                            Text(letter.descrTraining)
                                .font(.title2)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .lineSpacing(6)
                            
                                .padding(.horizontal, 20)
                            
                            Spacer() // Push content upward
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height) // Match container size
                        
                    }
                        Spacer(minLength: 40) // Space between text and buttons

                        // Buttons Below the Text
                        VStack{ // Adjust spacing between buttons
                            Button("إكمال المستوى") {
                                onComplete()
                            }
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(12)

                            Button("عودة") {
                                onBack()
                            }
                            .padding()
                            .frame(width: 200, height: 50)
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
        
                
                }
                .padding(.bottom, 10)

               
            }
             .edgesIgnoringSafeArea(.top)
        }
    }


