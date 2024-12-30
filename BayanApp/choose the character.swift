import SwiftUI

struct CharacterPage: View {
    // Colors and States
    let lightGreen = Color(red: 0/255, green: 110/255, blue: 127/255 )
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
    
    // Dynamically calculated screen width and height proportions
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Header Texts
                VStack(spacing: 20) {
                    Text("مرحباً أيها البطل!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.top, screenHeight * 0.1)  // Proportional top padding

                    Text("اختر شخصية طفلك")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                }

                // Buttons Section
                VStack(spacing: 10) {
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: screenWidth * 0.1),
                            GridItem(.flexible(), spacing: screenWidth * 0.1)
                        ],
                        spacing: screenWidth * 0.2  // Adjusted based on screen width
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
                                .frame(width: screenWidth * 0.4, height: screenWidth * 0.4)  // Dynamic size for the button
                            }
                        }
                    }
                }
                .padding()

                // Name Input Field
                VStack(spacing: 10) {
                    Text("أدخل اسم طفلك")
                        .font(.headline)
                        .multilineTextAlignment(.center)

                    TextField("أدخل اسم طفلك هنا", text: $name)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                        .padding(.horizontal, screenWidth * 0.2)  // Dynamic horizontal padding
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
                            .padding(.horizontal, screenWidth * 0.1)  // Proportional padding
                    }
                }
            }
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

// Reusable Circle Button Component
struct CircleButtonView: View {
    let imageName: String
    let isSelected: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(isSelected ? Color.yellow.opacity(0.2) : Color(.systemGray6))
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
