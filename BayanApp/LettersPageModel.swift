//
//  LettersPageModel.swift
//  TestLearning
//
//  Created by Wafa Awad  on 25/12/2024.
//
//letter,animel,vioce, Pron, descridtion1,describtion2,,evation
//MODEL
import SwiftUI
import Foundation
struct LettterModel: Identifiable{
    var id: UUID = UUID()
    var letter:String
    var animel:String
    var sound:String
    var descLearning:String
    var descrTraining:String
    var ImageProunounce: String
}

//modelView



class LettersViewModel: ObservableObject {
    // Published property for the letters
    @Published var letters: [LettterModel]

    // Initialize with mock data
    init() {
        self.letters = [
            LettterModel(
                letter: "ر",
                animel: "Raccoon",
                sound: "Rletter",
                descLearning: "jyfiy;igo;b;",
                descrTraining: "Practice saying 'A' while looking at the image of the alligator.",
                ImageProunounce: "R"
            ),
            LettterModel(
                letter: "ك",
                animel: "kangaroo",
                sound: "Kletter",
                descLearning:"jhougi;ug;i" ,
                descrTraining: "Practice saying 'B' while looking at the image of the bear.",
                ImageProunounce:"K"
            )
        ]
    }
}


    
