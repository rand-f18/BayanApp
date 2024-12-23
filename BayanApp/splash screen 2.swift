//
//  ContentView.swift
//  BayanApp
//
//  Created by Rand Soliman Alobaid on 17/06/1446 AH.
//

import SwiftUI

struct ContentView: View {
    
    @State var isActive: Bool = false

    var body: some View {
        ZStack {
            if self.isActive {
                PageTowView()
            } else {
                VStack { // ترتيب الصور عموديًا
                    Image("ana.mm") // الصورة الأولى
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200) // التحكم في حجم الصورة
                        .padding(.top,400) // مسافة من الأعلى
                    
                    Spacer() // فصل الصور بمساحة مرنة
                    
                    Image("ana.mm") // الصورة الثانية
                        .resizable()
                        .scaledToFit()
                
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
