

import SwiftUI

// Reusable model for Animal
struct Animal {
    var name: String
}

// View to display Animal's image with controllable position
struct AnimalImageView: View {
    var animal: Animal
    var xOffset: CGFloat // Horizontal offset
    var yOffset: CGFloat // Vertical offset

    var body: some View {
        Image(animal.name) // Use the animal name to display the correct image
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .padding(.top, 20) // Adjust padding as needed
            .offset(x: xOffset, y: yOffset) // Control the image position
    }
}

