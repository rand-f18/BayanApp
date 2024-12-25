import SwiftUI

struct LettersView: View {
    let lightGreen = Color(red: 0.94, green: 0.98, blue: 0.92)

    @ObservedObject var object = LettersViewModel()

    // State properties for navigation
    @State private var selectedLetter = LettterModel(
        letter: "ر",
        animel: "Alligator",
        sound: "Rletter",
        descLearning: "A is for Alligator, a big reptile with sharp teeth.",
        descrTraining: "Practice saying 'A' while looking at the image of the alligator.",
        ImageProunounce: "alligator_image"
    )
    @State private var navigateToMap = false

    var body: some View {
            NavigationStack {
                VStack(spacing: 20) {
                    ForEach(object.letters.indices, id: \.self) { index in
                        let letter = object.letters[index]
                        Button(action: {
                            selectedLetter = letter
                            navigateToMap = true
                        }) {
                            HStack {
                                Text("Letter: \(letter.letter)")
                                    .font(.headline)
                                Spacer()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(lightGreen)
                            .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding()
//                .navigationDestination(for: LettterModel.self) { letter in
//                    MapViewForKLetter(letter: letter)
//                }
                .navigationDestination(isPresented: $navigateToMap) {
                    MapViewForKLetter(letter: $selectedLetter)
                }
            }
            .onAppear {
                print("Loaded Letters: \(object.letters)")
            }
        }
}

