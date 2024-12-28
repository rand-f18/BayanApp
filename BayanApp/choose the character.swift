import SwiftUI

struct CharacterPage: View {
    let lightGreen = Color(red: 0.94, green: 0.98, blue: 0.92)
    @State private var name: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // Use a @State variable to store button data dynamically
    @State private var buttonData: [(imageName: String, label: String, destination: AnyView?)] = [
        (imageName: "Character1", label: "boyl", destination: nil),
        (imageName: "Character2", label: "boy2", destination: nil)
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Background color and text
                Color(UIColor.systemBackground)
                    .edgesIgnoringSafeArea(.all)
                
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
                
                // Name TextField
                TextField("أدخل اسمك هنا", text: $name)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
                
                // Grid Layout for buttons
                VStack {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(lightGreen)
                        .frame(maxWidth: .infinity, maxHeight: 800) // Adjusted frame for better responsiveness
                        .overlay(
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
                                                Image(data.imageName) // Replace with your actual image asset names
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 200, height: 200)
                                                    .clipShape(Circle()) // Ensures the button matches the image shape
                                                    .shadow(radius: 5)
                                            }
                                        }
                                    } else {
                                        Button(action: {
                                            // Show alert if no destination
                                            alertMessage = "هذه الصفحة تحت الإنشاء."
                                            showAlert = true
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
                        )
                }
                .padding()
                Spacer() // Ensures content stays at the top, filling the rest of the space
                
  
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("تحت الإنشاء"), message: Text(alertMessage), dismissButton: .default(Text("حسناً")))
            }
          
        }
        .onAppear {
            // Dynamically update the destination when the view appears
            buttonData[0].destination = AnyView(LettersView(name: $name))  // Update the destination with the current name binding
        }
    }
}

