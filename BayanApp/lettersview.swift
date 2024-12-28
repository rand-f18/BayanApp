import SwiftUI

struct LettersView: View {
    let lightGreen = Color(red: 0.94, green: 0.98, blue: 0.92)
    
    @ObservedObject var object = LettersViewModel()
    
    // State properties for navigation
    @State private var selectedLetter = LettterModel(
        letter: "ث",
        animel: "Th",
        sound: "letter",
        descLearning:"يخرج صوت الثاء بتقارب طرف اللسان مع الأسنان العلوية والسفلية\nويلاحظ تقدم طرف اللسان نسبة إلى الفم أكثر من الذال والظاء" ,
        descrTraining: "١-يضع الطففل طرف اللسان بين الأسنان الأمامية والسفلية\nثم يضع يده أمام فمه ليشعر باستمرارية الهواء الخارج من فمه ",
        ImageProunounce:"Th"
    )
    
    @Binding var name: String
    @State private var navigateToMap = false
    
    var body: some View {
        
        VStack(spacing: 20) {
            Text(name)
                .padding()
                .frame(height: 50)
                .background(Color.secondary)
                .cornerRadius(30)
                .padding(.horizontal, 16) // Aligns with other elements
        }
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
        
        .padding()
        //                .navigationDestination(for: LettterModel.self) { letter in
        //                    MapViewForKLetter(letter: letter)
        //                }
        .navigationDestination(isPresented: $navigateToMap) {
            MapViewForKLetter(letter: $selectedLetter)
        }
        
        
        .onAppear {
            print("Loaded Letters: \(object.letters)")
        }
    }
}

