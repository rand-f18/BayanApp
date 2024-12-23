//
//  Turtle.swift
//  BayanApp
//
//  Created by Tahani Mohammed Alhawsawi on 18/06/1446 AH.
//

import Foundation

import Foundation
import SwiftUI
struct Turtle: View {
    var body: some View {
        NavigationStack {
            ZStack {
            Image("Turtlemap")
                .resizable()
                .frame(width: 833, height: 1220)
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                Image("المرحلة3")
                    .resizable()
                    .frame(width: 230, height: 230)
                    .offset(x: 270, y: 630)
                
                Text("انطلق 🚀")
                    .font(.system(size: 30))
                    .frame(width: 252, height: 252)
                    .offset(x: 269, y: 400)
                    .foregroundColor(.black)
                Image("المرحلة2")
                    .resizable()
                    .frame(width: 230, height: 230)
                    .offset(x: -150, y: 450)
                Text("تدرب 🧩")
                    .font(.system(size: 30))
                    .frame(width: 250, height: 250)
                    .offset(x: -160, y: 210)
                    .foregroundColor(.black)
                
                Image("المرحلة1")
                    .resizable()
                    .frame(width: 260, height: 260)
                    .offset(x: 280, y: 152)
                NavigationLink(destination:LetterKView())
                {  Text("تعلم⭐️")
                        .font(.system(size: 30))
                        .frame(width: 250, height: 250)
                        .offset(x: 266, y: -93)
                        .foregroundColor(.black)
                }
                Image("Note")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .offset(x: -109, y: -200)
                Text("مرحبًا يا صديقي🌟 \nهل تستطيع مساعدتي بالوصول إليك؟ اجمع النجوم من خلال تجاوز المراحل الممتعة التالية\n لننطلق معا!")
                    
                    .frame(width: 150, height: 250).font(.system(size: 13))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                    .offset(x: -97, y: -495)
            }
            
        }
    }
}
}
#Preview {
    Turtle() // عرض الصفحة في المعاينة
}
