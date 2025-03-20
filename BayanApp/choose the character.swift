
import SwiftUI

struct CharacterPage: View {
    // Colors and States
    private let lightGreen = Color(red: 0/255, green: 110/255, blue: 127/255)
    @State private var name: String = ""
    @State private var selectedCharacter: String? = nil
    @State private var showAlert = false
    @State private var navigateToLettersView = false
    @State private var selectedImageName: String = ""

    // Character Selection Data
    let buttonData: [(imageName: String, label: String)] = [
        (imageName: "Girl", label: "girl1"),
        (imageName: "happyboy", label: "boy1")
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: UIScreen.main.bounds.height * 0.05) {
                // MARK: - Header Texts
                VStack(spacing: UIScreen.main.bounds.height * 0.02) {
                    Text("مرحباً أيها البطل!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.top, UIScreen.main.bounds.height * 0.15)

                    Text("اختر شخصية طفلك")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                }

                // MARK: - Character Selection
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], spacing: 20) {
                    ForEach(buttonData, id: \.imageName) { data in
                        Button(action: {
                            selectedCharacter = data.label
                            selectedImageName = data.imageName
                        }) {
                            CircleButtonView(
                                imageName: data.imageName,
                                isSelected: selectedCharacter == data.label
                            )
                        }
                    }
                }
                .padding(.horizontal)

                // MARK: - Name Input
                VStack(spacing: 10) {
                    Text("أدخل اسم طفلك")
                        .font(.headline)
                        .multilineTextAlignment(.center)

                    TextField("أدخل اسم طفلك هنا", text: $name)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                        .padding(.horizontal, 40)
                }

                Spacer()

                // MARK: - Navigation Button
                NavigationLink(
                    destination: LettersView(name: $name, imageName: $selectedImageName),
                    isActive: $navigateToLettersView
                ) {
                    Button(action: {
                        if name.isEmpty || selectedCharacter == nil {
                            showAlert = true
                        } else {
                            navigateToLettersView = true
                        }
                    }) {
                        Text("اكمل")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(lightGreen)
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("تنبيه"),
                        message: Text("يرجى إدخال الاسم واختيار الشخصية."),
                        dismissButton: .default(Text("حسناً"))
                    )
                }
                .padding(.bottom, UIScreen.main.bounds.height * 0.05)
            }
        }
    }
}

// MARK: - Circle Button Component
struct CircleButtonView: View {
    let imageName: String
    let isSelected: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(isSelected ? Color.yellow.opacity(0.2) : Color(.systemGray6))
                .frame(width: 120, height: 120)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(isSelected ? Color.yellow : Color.clear, lineWidth: 4)
                )
                .shadow(radius: 5)

            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
        }
        .animation(.easeInOut, value: isSelected)
    }
}

// MARK: - Preview
struct CharacterPage_Previews: PreviewProvider {
    static var previews: some View {
        CharacterPage()
            .previewDevice("iPhone 14")
            .environment(\.locale, .init(identifier: "ar")) // Arabic layout
    }
}
