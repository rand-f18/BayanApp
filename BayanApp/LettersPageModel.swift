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
                          letter: "ث",
                      animel: "Th",
                      sound: "letter",
                      descLearning:"يخرج صوت الثاء بتقارب طرف اللسان مع الأسنان العلوية والسفلية\nويلاحظ تقدم طرف اللسان نسبة إلى الفم أكثر من الذال والظاء" ,
                      descrTraining: "١-يضع الطففل طرف اللسان بين الأسنان الأمامية والسفلية\nثم يضع يده أمام فمه ليشعر باستمرارية الهواء الخارج من فمه ",
                      ImageProunounce:"Th"
                  ),
                  LettterModel(
                       letter: "ج",
                      animel: "G",
                      sound: "Kletter",
                      descLearning:"يلتقي وسط اللسان بسقف الحنك التقاء محكماً بحيث ينحبس مجرى الهواء \nوإذا انفصل العضوان انفصالاً بطيئاً يسمع صوت الجيم" ,
                      descrTraining: "١-يضع الطفل يده اليمنى تحت الذقن للشد على الحنك\n٢-و يضع يده الاخرى على حنجرته وذلك لكي يشعر بالاهتزازات الناتجة عند إخراج الصوت",
                      ImageProunounce:"G"
                  ),
                  LettterModel(
                       letter: "خ",
                      animel: "Kh",
                      sound: "Kletter",
                      descLearning:"يقع مخرج صوت الخاء أدنى الحلق عند منطقة جذر اللسان \nمع سقف الحلق الرخو " ,
                      descrTraining: "يضع الطفل يده على رقبته ليشعر بالاهتزازات الصادرة نتيجة إنتاج الصوت ",
                      ImageProunounce:"Kh"
          
                  ),
                  LettterModel(
                          letter: "ر",
                      animel: "R",
                      sound: "Rletter",
                      descLearning: "يتكون صوت الراء بواسطة التقاء طرف اللسان باللثة\nويبتعد عنها مرات عديدة فيسمع الصوت على صورة مجموعة من الانسحابات والانفجارات",
                      descrTraining: "١-استخدم قابض اللسان لوضعه فوق اﻷسنان لوضعه فوق الاسنان \nالامامية السفلية تخت الاسنان كمساعد لإخراج الصوت مع وضع مرآة امام الطفل",
                      ImageProunounce: "R"
                  ),
                  LettterModel(
                      letter: "س",
                      animel: "S",
                      sound: "Sletter",
                      descLearning:"يتكون صوت السين بتطابق الأسنان الامامية العليا على السفلى نسبياً\nووضع طرف اللسان خلف الأسنان العليا السفلى " ,
                      descrTraining: "١- يضع الطفل يده أمام فمه لكي يشع بالهواء البارد الخارج من فمه عند إنتاج الصوت\nيجب ملاحظة الفم بحيث يكون مبتسماً عند إنتاج الصوت(استخدم المرآة لملاحظة ذلك) ",
                      ImageProunounce:"S"
                  ),
                  LettterModel(
                         letter: "ش",
                      animel: "Sh",
                      sound: "Kletter",
                      descLearning:"يتكون صوت الشين بالتصاق طرف ووسط اللسان بالجزء العلوي الأمامي\nويصدر الصوت بشكل مشوشاً" ,
                      descrTraining: "١- يضع الطفل يده أمام فمه لكي يحس بالهواء الساخن عن إنتاج الصوت \n٢-يجب ملاحظة وضع الفم بحيث يكون مضموماً قليلاً عند إنتاج الصوت أكثر من صوت السين (استخدم المرآة لملاحظة ذلك)",
                      ImageProunounce:"Sh"
                  ),
                  LettterModel(
                    letter: "غ",
                      animel: "Gh",
                      sound: "Gletter",
                      descLearning:"تخرج الغين من أدنى الحلق مع منطقة الحنك اللحمي \nوقبل اللهاة مباشرة مع أصل اللسان" ,
                      descrTraining: "١-اطلب من الطفل وضع كمية من الماء في فمه ويطلب منه تحريكها عندة مرات على ان تبقى محجوزة في فمه (يقوم بالغرغره)\n٢-لكي يشعر الطفل بالصوت أيضاً فعليه أن يضع يده على حنجرته أثناء إنتاج الغين ",
                      ImageProunounce:"Gh"
          
                  ),
                  LettterModel(
                     letter: "ك",
                      animel: "K",
                      sound: "Kletter",
                      descLearning:"jhougi;ug;i" ,
                      descrTraining: "١-يرتفع أقصى اللسان حتى يلتقي بأاقصى الحنك الأعلى مع ضغط\n٢-اندفاع الهواء مع انخفاض اللسان محدثا عند اندفاعه صوتا انفجاريا وهو صوت الكاف ",
                      ImageProunounce:"K"
                  ),
              ]
          }
      }
