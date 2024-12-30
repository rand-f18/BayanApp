import SwiftUI

struct TrainingView: View {
    @Binding var letter: LettterModel
    let onComplete: () -> Void
    let onBack: () -> Void
    let lightGreen = Color(red: 0 / 255, green: 110 / 255, blue: 127 / 255)

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
                        .padding()
                        .multilineTextAlignment(.center)

                    Spacer(minLength: 20)

                    // MARK: Buttons Section
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
    
        .navigationBarBackButtonHidden(true)  // Hide default back button
        .toolbar {
            // Use the CustomBackButton with onBack action passed here
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton(onBack: onBack)  // Pass the onBack closure
            }
        }
    }
}

