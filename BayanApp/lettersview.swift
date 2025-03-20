import SwiftUI

struct LettersView: View {
    private let lightGreen = Color(red: 0/255, green: 110/255, blue: 127/255)
    
    @ObservedObject var object = LettersViewModel()
    @Environment(\.presentationMode) private var presentationMode
    @State private var selectedLetter = LetterModel(
        letter: "ث",
        animel: "Th",
        sound: "letter",
        descLearning: "يخرج صوت الثاء بتقارب طرف اللسان مع الأسنان العلوية والسفلية\nويلاحظ تقدم طرف اللسان نسبة إلى الفم أكثر من الذال والظاء",
        descrTraining: "١-يضع الطفل طرف اللسان بين الأسنان الأمامية والسفلية\nثم يضع يده أمام فمه ليشعر باستمرارية الهواء الخارج من فمه",
        ImageProunounce: "Th",
        buttonImage: "FoxButtton"
    )

    @Binding var name: String
    @Binding var imageName: String
    @State private var navigateToMap = false

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack(spacing: 0) {
            // Top Header
            ZStack {
                lightGreen
                    .ignoresSafeArea()
                    .frame(height: UIScreen.main.bounds.height * 0.168) // Set a specific height

                HStack {
                    VStack(alignment: .leading) {
                        Text("مرحبًا \(name)، لنبدأ بالتعلم!")
                            .foregroundColor(.white)
                            .font(.system(size: UIScreen.main.bounds.width * 0.05)) // Responsive font size
                            .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: UIScreen.main.bounds.width * 0.17)
                        
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width * 0.15)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
            }

            // Letters Grid
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(object.letters.indices, id: \.self) { index in
                        let letter = object.letters[index]
                        Button(action: {
                            selectedLetter = letter
                            navigateToMap = true
                        }) {
                            Image( letter.buttonImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width * 0.42, height: UIScreen.main.bounds.width * 0.42)
                                .cornerRadius(10)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
            }
        }
        .navigationDestination(isPresented: $navigateToMap) {
            MapViewForKLetter(letter: $selectedLetter)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton(onBack: {
                    presentationMode.wrappedValue.dismiss()
                }, iconColor: .white)
            }
        }
    }
}

// MARK: - Preview
struct LettersView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyName = "علي"
        let dummyImageName = "Girl"

        let dummyViewModel = LettersViewModel()
        dummyViewModel.letters = [
            LetterModel(letter: "أ", animel: "A", sound: "letterA", descLearning: "صوت الألف...", descrTraining: "يقول الألف...", ImageProunounce: "A", buttonImage: "ButtonImage1"),
            LetterModel(letter: "ب", animel: "B", sound: "letterB", descLearning: "صوت الباء...", descrTraining: "يقول الباء...", ImageProunounce: "B", buttonImage: "ButtonImage2")
        ]

        return LettersView(name: .constant(dummyName), imageName: .constant(dummyImageName))
            .environmentObject(dummyViewModel)
    }
}

