import SwiftUI
import Foundation

// Corrected model name
struct LettterModel: Identifiable {
    var id: UUID = UUID()
    var letter: String
    var animel: String
    var sound: String
    var descLearning: String
    var descrTraining: String
    var ImageProunounce: String
    var buttonImage: String
}

// ViewModel for managing letters data
class LettersViewModel: ObservableObject {
    // Published property for the letters
    @Published var letters: [LettterModel]

    // Initialize with mock data
    init() {
        self.letters = [
            LettterModel(
                letter: "ث",
                animel: "fox",
                sound: "ThLetter",
                descLearning: "يخرج صوت الثاء بتقارب طرف اللسان مع الأسنان العلوية والسفلية\nويلاحظ تقدم طرف اللسان نسبة إلى الفم أكثر من الذال والظاء",
                descrTraining: "١-يضع الطففل طرف اللسان بين الأسنان الأمامية والسفلية\nثم يضع يده أمام فمه ليشعر باستمرارية الهواء الخارج من فمه ",
                ImageProunounce: "Th",
                buttonImage: "FoxButtton"
            ),
            LettterModel(
                letter: "ج",
                animel: "camel",
                sound: "Gletter",
                descLearning: "يلتقي وسط اللسان بسقف الحنك التقاء محكماً بحيث ينحبس مجرى الهواء\nوإذا انفصل العضوان انفصالاً بطيئاً يسمع صوت الجيم",
                descrTraining: "١-يضع الطفل يده اليمنى تحت الذقن للشد على الحنك\n٢-و يضع يده الاخرى على حنجرته وذلك لكي يشعر بالاهتزازات الناتجة عند إخراج الصوت",
                ImageProunounce: "Gem",
                buttonImage: "camelButton"
            ),
            LettterModel(
                letter: "خ",
                animel: "sheep",
                sound: "KhLetter",
                descLearning: "يقع مخرج صوت الخاء أدنى الحلق عند منطقة جذر اللسان\nمع سقف الحلق الرخو",
                descrTraining: "يضع الطفل يده على رقبته ليشعر بالاهتزازات الصادرة نتيجة إنتاج الصوت ",
                ImageProunounce: "Kh",
                buttonImage: "SheepButton"
            ),
            LettterModel(
                letter: "ر",
                animel: "Raccoon",
                sound: "Rletter",
                descLearning: "يتكون صوت الراء بواسطة التقاء طرف اللسان باللثة\nويبتعد عنها مرات عديدة فيسمع الصوت على صورة مجموعة من الانسحابات والانفجارات",
                descrTraining: "١-استخدم قابض اللسان لوضعه فوق اﻷسنان لوضعه فوق الاسنان\nالامامية السفلية تخت الاسنان كمساعد لإخراج الصوت مع وضع مرآة امام الطفل",
                ImageProunounce: "Ra",
                buttonImage: "RacconButton"
            ),
            LettterModel(
                letter: "س",
                animel: "turtle",
                sound: "Sletter",
                descLearning: "يتكون صوت السين بتطابق الأسنان الامامية العليا على السفلى نسبياً\nووضع طرف اللسان خلف الأسنان العليا السفلى",
                descrTraining: "١- يضع الطفل يده أمام فمه لكي يشع بالهواء البارد الخارج من فمه عند إنتاج الصوت\nيجب ملاحظة الفم بحيث يكون مبتسماً عند إنتاج الصوت(استخدم المرآة لملاحظة ذلك) ",
                ImageProunounce: "Sa",
                buttonImage: "TurtleButton"
            ),
            LettterModel(
                letter: "ش",
                animel: "lion",
                sound: "ShLetter",
                descLearning: "يتكون صوت الشين بالتصاق طرف ووسط اللسان بالجزء العلوي الأمامي\nويصدر الصوت بشكل مشوشاً",
                descrTraining: "١- يضع الطفل يده أمام فمه لكي يحس بالهواء الساخن عن إنتاج الصوت\n٢-يجب ملاحظة وضع الفم بحيث يكون مضموماً قليلاً عند إنتاج الصوت أكثر من صوت السين (استخدم المرآة لملاحظة ذلك)",
                ImageProunounce: "Shen",
                buttonImage: "LionButton"
            ),
            LettterModel(
                letter: "غ",
                animel: "gazelle",
                sound: "Ghletter",
                descLearning: "تخرج الغين من أدنى الحلق مع منطقة الحنك اللحمي\nوقبل اللهاة مباشرة مع أصل اللسان",
                descrTraining: "١-اطلب من الطفل وضع كمية من الماء في فمه ويطلب منه تحريكها عندة مرات على ان تبقى محجوزة في فمه (يقوم بالغرغره)\n٢-لكي يشعر الطفل بالصوت أيضاً فعليه أن يضع يده على حنجرته أثناء إنتاج الغين",
                ImageProunounce: "Gen",
                buttonImage: "GazelleButton"
            ),
            LettterModel(
                letter: "ك",
                animel: "kangaroo",
                sound: "Kletter",
                descLearning: "jhougi;ug;i",
                descrTraining: "١-يرتفع أقصى اللسان حتى يلتقي بأاقصى الحنك الأعلى مع ضغط\n٢-اندفاع الهواء مع انخفاض اللسان محدثا عند اندفاعه صوتا انفجاريا وهو صوت الكاف",
                ImageProunounce: "Kaf",
                buttonImage: "kangrooButton"
            )
        ]
    }
}
////import SwiftUI

// MARK: - Custom Back Button View
import SwiftUI

struct CustomBackButton: View {
    let onBack: () -> Void
    let iconColor: Color

    var body: some View {
        Button(action: {
            onBack()  // Call the onBack closure
        }) {
            HStack {
                Image(systemName: "arrow.left.circle.fill")
                    .font(.title)
                    .foregroundColor(iconColor) // Use the passed color
//                Text("Back")
//                    .font(.headline)
//                    .foregroundColor(iconColor) // Use the passed color
            }
        }
    }
}



// MARK: - Custom Button Style
struct CustomButtonStyle: ButtonStyle {
    var backgroundColor: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // Adds a subtle scaling effect when pressed
    }
}


