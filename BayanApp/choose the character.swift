import SwiftUI

struct CharacterPage: View {
    // Colors and States
    let lightGreen = Color(red: 0/255, green: 110/255, blue: 127/255 )
    let redButtonColor = Color.red
    @State private var name: String = ""
    @State private var selectedCharacter: String? = nil
    @State private var showAlert = false
    @State private var navigateToLettersView = false

    // Dynamic button data
    let buttonData: [(imageName: String, label: String)] = [
        (imageName: "Girl", label: "girl1"),
        (imageName: "happyboy", label: "boy1")
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Header Texts
                VStack(spacing: 20) {
                    Text("مرحباً أيها البطل!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.top, 228.509)

                    Text("اختر شخصية طفلك")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                }

                // Buttons Section
                VStack(spacing: 10) {
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing:-250),
                            GridItem(.flexible(), spacing: -250)
                        ],
                        spacing: 250
                    ) {
                        ForEach(buttonData, id: \.imageName) { data in
                            Button(action: {
                                selectedCharacter = data.label
                            }) {
                                CircleButtonView(
                                    imageName: data.imageName,
                                    isSelected: selectedCharacter == data.label
                                )
                            }
                        }
                    }
                }
                .padding()

                
                VStack(spacing: 10) {
                                Text("أدخل اسم طفلك")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                

                                TextField("أدخل اسم طفلك هنا", text: $name)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(20)
                                    .padding(.horizontal, 156.747)
                            }

                            Spacer()

                            // Red Button
                            NavigationLink(
                                destination: LettersView(name: $name),
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
                        }
                        .padding(.top, 20) // تعديل المسافة العلوية
                        .padding(.bottom, 30) // تعديل المسافة السفلية
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
                .frame(width: 150, height: 150)
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
