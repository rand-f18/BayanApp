import SwiftUI

struct TrainingView: View {
    @Binding var letter: LetterModel 
    let onComplete: () -> Void
    let onBack: () -> Void
    
    // Made `lightGreen` a private constant
    private let lightGreen = Color(red: 0 / 255, green: 110 / 255, blue: 127 / 255)
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                // Background container
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(.secondary.opacity(0.1))
                    .padding()
                
                VStack(spacing: 20) {
                    Text(letter.descrTraining)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding()
                    
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
    }
}
