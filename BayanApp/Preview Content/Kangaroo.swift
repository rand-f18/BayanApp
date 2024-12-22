import SwiftUI

struct Kangaroo: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                // Background Image
                Image("Kangaroomap")
                
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                  
                    .edgesIgnoringSafeArea(.all)
                    
                
                VStack {
                    // Stage 3
                    ZStack {
                        Image("المرحلة3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width * 0.25)
                        Text("انطلق 🚀")
                            .font(.system(size: geometry.size.width * 0.045))
                            .foregroundColor(.black)
                    }
                    .offset(x: geometry.size.width * 0.4, y: geometry.size.height * 0.2)
                    
                    // Stage 2
                    ZStack {
                        Image("المرحلة2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width * 0.25)
                        Text("تدرب 🧩")
                            .font(.system(size: geometry.size.width * 0.05))
                            .foregroundColor(.black)
                    }
                    .offset(x: -geometry.size.width * 0.1, y: geometry.size.height * 0.1)
                    
                    // Stage 1
                    ZStack {
                        Image("المرحلة1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width * 0.3)
                        Text("تعلم⭐️")
                            .font(.system(size: geometry.size.width * 0.05))
                            .foregroundColor(.black)
                    }
                    .offset(x: geometry.size.width * 0.4, y: geometry.size.height * 0.1)
                    
                    // Note
                    VStack {
                        Image("Note")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width * 0.3)
                        Text("مرحبًا يا صديقي🌟 \nهل تستطيع مساعدتي بالوصول إليك؟ اجمع  النجوم من خلال تجاوز المراحل الممتعة التالية\n لننطلق معا!")
                            .font(.system(size: geometry.size.width * 0.03))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    .offset(x: -geometry.size.width * 0.15, y: -geometry.size.height * 0.3)
                }
            }
        
            
        }
    }
}

#Preview {
    Kangaroo()
}

