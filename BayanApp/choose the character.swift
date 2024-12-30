import SwiftUI

struct CharacterPage: View {
    // Colors and States
    let lightGreen = Color(red: 0/255, green: 110/255, blue: 127/255)
    @State private var name: String = ""
    @State private var selectedCharacter: String? = nil
    @State private var showAlert = false
    @State private var navigateToLettersView = false
    @State private var selectedImageName: String = ""

    // Dynamic button data
    let buttonData: [(imageName: String, label: String)] = [
        (imageName: "Girl", label: "girl1"),
        (imageName: "happyboy", label: "boy1")
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: UIScreen.main.bounds.height * 0.05) {
                // Header Texts
                VStack(spacing: UIScreen.main.bounds.height * 0.02) {
                    Text("مرحباً أيها البطل!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.top, UIScreen.main.bounds.height * 0.2)

                    Text("اختر شخصية طفلك")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                }

                // Buttons Section
                VStack(spacing: UIScreen.main.bounds.height * 0.02) {
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ],
                        spacing: UIScreen.main.bounds.height * 0.05
                    ) {
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
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.1)

                }

                // Name Input Section
                VStack(spacing: UIScreen.main.bounds.height * 0.02) {
                    Text("أدخل اسم طفلك")
                        .font(.headline)
                        .multilineTextAlignment(.center)

                    TextField("أدخل اسم طفلك هنا", text: $name)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                        .padding(.horizontal, UIScreen.main.bounds.width * 0.1)
                }

                Spacer()

                // Red Button
                NavigationLink(
                    destination: LettersView(name: $name, imageName: $selectedImageName),  // Pass the binding
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
                            .padding(.horizontal, UIScreen.main.bounds.width * 0.1)
                    }
                }
                .padding(.top, UIScreen.main.bounds.height * 0.02)
                .padding(.bottom, UIScreen.main.bounds.height * 0.05)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("تنبيه"),
                        message: Text("يرجى إدخال الاسم واختيار الشخصية."),
                        dismissButton: .default(Text("حسناً"))
                    )
                }
            }
        }
    }
}

// Reusable Circle Button Component
struct CircleButtonView: View {
    let imageName: String
    let isSelected: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(isSelected ? Color.yellow.opacity(0.2) : Color(.systemGray6))
                .frame(width: UIScreen.main.bounds.width * 0.28, height: UIScreen.main.bounds.width * 0.28) // Geometric size
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(isSelected ? Color.yellow : Color.clear, lineWidth: 4)
                )
                .shadow(radius: 5)

            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25) // Geometric size
        }
        .animation(.easeInOut, value: isSelected)
    }
}

// Preview Provider
struct CharacterPage_Previews: PreviewProvider {
    static var previews: some View {
        CharacterPage()
            .previewDevice("iPhone 14") // Preview on an iPhone 14
            .environment(\.locale, .init(identifier: "ar")) // Set Arabic locale for preview
    }
}
