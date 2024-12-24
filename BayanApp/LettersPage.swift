import SwiftUI

struct LettersView: View {
    let lightGreen = Color(red: 0.94, green: 0.98, blue: 0.92)
    let name: String
    @Binding var isTrainUnlocked: Bool
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLaunchUnlocked: Bool = false

    let buttonData: [LetterModel] = [
        LetterModel(letter: "ج", soundAssetName: "Gletter", description: "Camel description", animal: Animal(name: "camel"), imageNames: ["camelButton"], lightGreenColor: .green),
        LetterModel(letter: "ث", soundAssetName: "FoxSound", description: "Fox description", animal: Animal(name: "fox"), imageNames: ["FoxButtton"], lightGreenColor: .orange),
        LetterModel(letter: "ش", soundAssetName: "LionSound", description: "Lion description", animal: Animal(name: "lion"), imageNames: ["LionButton"], lightGreenColor: .purple),
        LetterModel(letter: "غ", soundAssetName: "GSound", description: "Gazelle description", animal: Animal(name: "gazelle"), imageNames: ["GazelleButton"], lightGreenColor: .red),
        LetterModel(letter: "ك", soundAssetName: "Kletter", description: "Kangaroo description", animal: Animal(name: "kangaroo"), imageNames: ["kangrooButton"], lightGreenColor: .blue),
        LetterModel(letter: "س", soundAssetName: "Sletter", description: "Turtle description", animal: Animal(name: "turtle"), imageNames: ["TurtleButton"], lightGreenColor: .green),
        LetterModel(letter: "ر", soundAssetName: "Rletter", description: "Raccoon description", animal: Animal(name: "raccoon"), imageNames: ["RacconButton"], lightGreenColor: .yellow),
        LetterModel(letter: "خ", soundAssetName: "SheepSound", description: "Sheep description", animal: Animal(name: "sheep"), imageNames: ["SheepButton"], lightGreenColor: .brown)
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Header Section
            ZStack(alignment: .leading) {
                lightGreen
                HStack(spacing: 20) {
                    Image("happyboy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .background(
                            Circle()
                                .fill(Color.green)
                                .frame(width: 180, height: 180)
                        )
                        .padding(.leading, 50)
                    
                    Text(name)
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
            .padding(.bottom, 20)
            .edgesIgnoringSafeArea(.all)
            
            Spacer()

            // Letters Grid
            ZStack {
                Color(UIColor.systemBackground)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(lightGreen)
                            .frame(maxWidth: 900, maxHeight: 800)
                            .padding()

                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                            ForEach(buttonData, id: \.letter) { letterModel in
                                LetterButtonView(letterModel: letterModel)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct LetterButtonView: View {
    var letterModel: LetterModel
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        Button(action: {
            if ["ش", "ف", "ج"].contains(letterModel.letter) {
                alertMessage = "The page for letter \(letterModel.letter) is under construction. Stay tuned!"
                showAlert = true
            } else {
                // Navigation logic for other letters
            }
        }) {
            VStack {
                Image(letterModel.imageNames.first ?? "defaultImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .shadow(radius: 20)
                    .overlay(
                        Text(letterModel.letter)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.leading, 35)
                            .cornerRadius(5)
                    )
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Notice"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct LettersView_Previews: PreviewProvider {
    static var previews: some View {
        LettersView(name: "Wafa", isTrainUnlocked: .constant(false))
    }
}

