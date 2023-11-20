import SwiftUI

enum BaggageAvailability {
    case available
    case conditional
    case unavailable
}

class BaggageItem {
    var classLabel: String
    var checkedBaggage: BaggageAvailability // 위탁 수하물
    var carryOnBaggage: BaggageAvailability // 기내 수하물
    var policyName: String
    var policyItems: [String]
    
    init(classLabel: String, checkedBaggage: BaggageAvailability, carryOnBaggage: BaggageAvailability, policyName: String, policyItems: [String]) {
        self.classLabel = classLabel
        self.checkedBaggage = checkedBaggage
        self.carryOnBaggage = carryOnBaggage
        self.policyName = policyName
        self.policyItems = policyItems
    }
}

class MainViewModel : ObservableObject {
    let baggageItems = [
        BaggageItem(
            classLabel: "스프레이류",
            checkedBaggage: .available,
            carryOnBaggage: .unavailable,
            policyName: "액체류",
            policyItems: [
                "음료, 식품, 화장품 등 액체류(스프레이) 및 젤류(젤 또는 크림) 물품",
                "콘택트렌즈 세척액",
                "개별 용기당 100ml 이하로 1인당 총 1L 용량의 비닐 지퍼백 1개",
                "액체류 음식류인 수프, 김치, 된장, 고추장, 홍삼정 같은 것도 액체로 보아 동일하게 100ml 이하로 1L 비닐 지퍼백에 담아 휴대 가능"
            ]
        )
    ]

    let baggageClassifier = try! BaggageClassifier()
    func classifyImage(image: UIImage) -> BaggageItem {
        let image = try! baggageClassifier.prediction(input: BaggageClassifierInput(sequential_7_inputWith: image.cgImage!))
        // return image.classLabel
        return baggageItems[0] // 임시
    }
}
