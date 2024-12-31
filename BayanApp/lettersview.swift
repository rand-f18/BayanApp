import SwiftUI

struct LettersView: View {
    let lightGreen = Color(red: 0/255, green: 110/255, blue: 127/255)
    @ObservedObject var object = LettersViewModel()
    @Environment(\.presentationMode) var presentationMode
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
    @Binding var imageName: String
    
    @State private var navigateToMap = false

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                lightGreen
                    .ignoresSafeArea()
                    .frame(height: UIScreen.main.bounds.height * 0.168) // Set a specific height for the light green area

                HStack {  // Use HStack to align text and image
                    VStack(alignment: .leading) {
                        Text("مرحبًا \(name)، لنبدأ بالتعلم!")
                            .foregroundColor(.white)
                            .font(.system(size: UIScreen.main.bounds.width * 0.05)) // Responsive font size
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.leading)

                    // Displaying the image from imageName with circular background
                    ZStack {
                        Circle()
                            .fill(Color.white)  // Background circle color
                            .frame(width: UIScreen.main.bounds.width * 0.17)  // Circle size

                        Image(imageName)  // Use the image name to create an Image view
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width * 0.15)  // Adjust the image size
                            .clipShape(Circle())  // Make the image circular
                    }
                    .padding(.leading, 20) // Adjust spacing between text and image
                }
                .padding(.vertical, UIScreen.main.bounds.height * 0.02) // Adjust vertical padding only
            }
            .frame(maxWidth: .infinity) // Keep max width for the ZStack
            
            ScrollView {
                // Letters grid
                LazyVGrid(columns: columns) { // Spacing between grid items
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
                                        width: UIScreen.main.bounds.width * 0.42, // 40% of screen width
                                        height: UIScreen.main.bounds.width * 0.42 // Keep square aspect ratio
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
        .navigationBarBackButtonHidden(true) // Hide the default back button
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        CustomBackButton(onBack: {
                            presentationMode.wrappedValue.dismiss() // Pop the view
                        }, iconColor:.white) // Use light blue for this page
                    }
                }
    }
}

// Preview Provider
struct LettersView_Previews: PreviewProvider {
    static var previews: some View {
        // Sample data for preview
        let dummyName = "علي"
        let dummyImageName = "Girl" // Replace with a valid image asset name

        // Create a dummy LettersViewModel for the preview
        let dummyViewModel = LettersViewModel()
        dummyViewModel.letters = [ // Populate with dummy letter data
            LettterModel(letter: "أ", animel: "A", sound: "letterA", descLearning: "صوت الألف...", descrTraining: "يقول الألف...", ImageProunounce: "A", buttonImage: "ButtonImage1"),
            LettterModel(letter: "ب", animel: "B", sound: "letterB", descLearning: "صوت الباء...", descrTraining: "يقول الباء...", ImageProunounce: "B", buttonImage: "ButtonImage2")
        ]

        return LettersView(name: .constant(dummyName), imageName: .constant(dummyImageName))
            .environmentObject(dummyViewModel) // Inject the dummy view model
    }
}
