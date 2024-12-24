import SwiftUI

extension Color {
    static let lightGreen = Color(red: 0.94, green: 0.98, blue: 0.92)
}

struct PageTowView: View {
    @State private var name: String = ""
    @State private var selectedCharacter: Int? = nil

    let buttonData: [(imageName: String, label: String, destination: AnyView?)] = [
        (imageName: "Character1", label: "Boy 1", destination: AnyView(LettersView(name: "", isTrainUnlocked: .constant(false)))),
        (imageName: "Character2", label: "Boy 2", destination: nil),
        (imageName: "Character3", label: "Girl 1", destination: nil),
        (imageName: "Character4", label: "Girl 2", destination: nil)
    ]
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemBackground)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    VStack(spacing: 10) {
                        Text("مرحباً أيها البطل!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)

                        Text("اكتب اسمك واختر شخصيتك\nواستعد لاكتشاف عالم مليء بالمرح والتعلم والتحديات")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)

                    TextField("Enter your name", text: $name)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)

                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.lightGreen)
                            .frame(width: 780, height: 800)

                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: 20),
                                GridItem(.flexible(), spacing: 20),
                            ],
                            spacing: 20
                        ) {
                            ForEach(buttonData, id: \.imageName) { data in
                                if let destination = data.destination {
                                    NavigationLink(destination: destination) {
                                        VStack {
                                            Image(data.imageName)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 200, height: 200)
                                                .clipShape(Circle())
                                                .shadow(radius: 5)
                                        }
                                    }
                                } else {
                                    Button(action: {
                                        if name.isEmpty {
                                            alertMessage = "Please enter your name before proceeding."
                                            showAlert = true
                                        } else {
                                            alertMessage = "\(data.label) is not yet available. Stay tuned for updates!"
                                            showAlert = true
                                        }
                                    }) {
                                        VStack {
                                            Image(data.imageName)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 200, height: 200)
                                                .clipShape(Circle())
                                                .shadow(radius: 5)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()

                    Spacer()
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Information"),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }
}

#Preview {
    PageTowView()
}

