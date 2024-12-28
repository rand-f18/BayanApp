import SwiftUI

struct LettersView: View {
    let lightGreen = Color(red: 0.94, green: 0.98, blue: 0.92)

    @ObservedObject var object = LettersViewModel()

    @State private var selectedLetter = LettterModel(
        letter: "ث",
        animel: "Th",
        sound: "letter",
        descLearning: "يخرج صوت الثاء بتقارب طرف اللسان مع الأسنان العلوية والسفلية\nويلاحظ تقدم طرف اللسان نسبة إلى الفم أكثر من الذال والظاء",
        descrTraining: "١-يضع الطفل طرف اللسان بين الأسنان الأمامية والسفلية\nثم يضع يده أمام فمه ليشعر باستمرارية الهواء الخارج من فمه",
        ImageProunounce: "Th",
        buttonImage: "FoxButtton"
    )

    @Binding var name: String
    @State private var navigateToMap = false

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Full-height section with green background
            ZStack {
                lightGreen
                    .ignoresSafeArea()

                VStack {
                    Text("مرحبًا \(name)، لنبدأ بالتعلم!")
                        .foregroundColor(.black)
                        .font(.system(size: 40))
                        
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 150)
            .padding(.bottom, 50)

            ScrollView {
                // Letters grid
                LazyVGrid(columns: columns) {
                    ForEach(object.letters.indices, id: \.self) { index in
                        let letter = object.letters[index]
                        Button(action: {
                            selectedLetter = letter
                            navigateToMap = true
                        }) {
                            ZStack {
                                Image(letter.buttonImage) // Button image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 400, height: 300) // Set the size
                                    .cornerRadius(10) // Optional: Round the corners

                                // Display the letter on the button
                                Text(letter.letter)
                                    .font(.system(size: 50))
                                    .foregroundColor(.black) // Change color as needed
                                    .bold() // Make the font bold
                                    .padding(.leading, 100) // Move it to the right
                            }
                        }
                        .buttonStyle(PlainButtonStyle()) // Removes default button styling
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .padding(.horizontal)
            .padding()
        }
        .navigationDestination(isPresented: $navigateToMap) {
            MapViewForKLetter(letter: $selectedLetter)
        }
        .onAppear {
            print(object.letters)
        }
    }
}

struct LettersView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyModel = LettersViewModel() // Ensure this has some data for preview
        let dummyName = "Preview Name"
        
        LettersView(name: .constant(dummyName))
            .environmentObject(dummyModel) // Use environment object if needed
    }
}
