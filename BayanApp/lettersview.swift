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
                        .font(.system(size: UIScreen.main.bounds.width * 0.08)) // Font size relative to screen width
                        .multilineTextAlignment(.center)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.2) // 20% of screen height
            .padding(.bottom, UIScreen.main.bounds.height * 0.05) // 5% of screen height as padding

            ScrollView {
                // Letters grid
                LazyVGrid(columns: columns, spacing: UIScreen.main.bounds.height * 0.02) { // Spacing between grid items
                    ForEach(object.letters.indices, id: \.self) { index in
                        let letter = object.letters[index]
                        Button(action: {
                            selectedLetter = letter
                            navigateToMap = true
                        }) {
                            ZStack {
                                Image(letter.buttonImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(
                                        width: UIScreen.main.bounds.width * 0.4, // 40% of screen width
                                        height: UIScreen.main.bounds.width * 0.4 // Keep square aspect ratio
                                    )
                                    .cornerRadius(10)
                            }
                        }
                        .buttonStyle(PlainButtonStyle()) // Removes default button styling
                    }
                }
            }
            .padding(.horizontal, UIScreen.main.bounds.width * 0.05) // Horizontal padding relative to screen width
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
        let dummyName = "Preview Name"
        LettersView(name: .constant(dummyName))
    }
}

