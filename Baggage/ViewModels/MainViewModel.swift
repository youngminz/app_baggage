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
            classLabel: "헤어스프레이",
            checkedBaggage: .available,
            carryOnBaggage: .conditional,
            policyName: "액체류",
            policyItems: [
                "헤어스프레이는 100ml 이하의 개별 용기에 포장되어야 함",
                "총 허용량은 지퍼백 1개에 1L까지이며, 지퍼백에 담아야 함"
            ]
        ),
        BaggageItem(
            classLabel: "라이터",
            checkedBaggage: .available,
            carryOnBaggage: .conditional,
            policyName: "라이터 및 안전성냥",
            policyItems: [
                "라이터는 1인당 1개로 제한, 기내 반입 가능",
                "중국 출발편은 휴대 및 위탁 모두 불가"
            ]
        ),
        BaggageItem(
            classLabel: "리뉴통 355ml",
            checkedBaggage: .available,
            carryOnBaggage: .conditional,
            policyName: "액체류",
            policyItems: [
                "리뉴통 355ml는 위탁 수하물로만 허용됨",
                "기내 반입 시 100ml 이하 개별 용기에 담긴 액체류만 허용"
            ]
        ),
        BaggageItem(
            classLabel: "처방전",
            checkedBaggage: .available,
            carryOnBaggage: .available,
            policyName: "의약품",
            policyItems: [
                "처방전 의약품은 의사의 소견서 또는 처방전 제시 시 기내 반입 가능"
            ]
        ),
        BaggageItem(
            classLabel: "약봉지",
            checkedBaggage: .available,
            carryOnBaggage: .available,
            policyName: "의약품",
            policyItems: [
                "개인용 의약품은 의사의 처방이 확인되면 기내 반입 가능"
            ]
        ),
        BaggageItem(
            classLabel: "고데기",
            checkedBaggage: .conditional,
            carryOnBaggage: .conditional,
            policyName: "전자기기",
            policyItems: [
                "일본 출발편 한정, 배터리 분리 불가한 고데기는 휴대/위탁 불가",
                "160Wh 이하 배터리는 분리 후 기내 반입 가능"
            ]
        ),
        BaggageItem(
            classLabel: "보조배터리",
            checkedBaggage: .unavailable,
            carryOnBaggage: .available,
            policyName: "보조/여분 리튬배터리",
            policyItems: [
                "160Wh 이하의 보조 배터리는 단락 방지 포장 후 기내 반입 가능",
                "100Wh 이하 최대 20개, 100Wh 초과 160Wh 이하 최대 2개 허용"
            ]
        ),
        BaggageItem(
            classLabel: "카레",
            checkedBaggage: .available,
            carryOnBaggage: .conditional,
            policyName: "액체류 음식",
            policyItems: [
                "액체류 음식(수프, 김치, 된장, 고추장 등)은 100ml 이하 용기에 담아 휴대 가능",
                "각 용기는 1L 총 용량의 비닐 지퍼백 내에 보관되어야 함"
            ]
        ),
        BaggageItem(
            classLabel: "음료수",
            checkedBaggage: .available,
            carryOnBaggage: .conditional,
            policyName: "액체류",
            policyItems: [
                "음료수는 100ml 용량 이내의 개별 용기에 담겨 있어야 함",
                "1인당 총 용량은 1L를 초과할 수 없으며, 비닐 지퍼백에 담아야 함"
            ]
        ),
        BaggageItem(
            classLabel: "가위",
            checkedBaggage: .available,
            carryOnBaggage: .conditional,
            policyName: "가위, 칼류",
            policyItems: [
                "날 길이 6cm 이하의 가위는 기내 반입 가능",
                "6cm를 초과하는 가위는 위탁 수하물로만 반입 가능"
            ]
        ),
        BaggageItem(
            classLabel: "눈썹칼",
            checkedBaggage: .available,
            carryOnBaggage: .conditional,
            policyName: "가위, 칼류",
            policyItems: [
                "눈썹칼은 기내 반입 가능",
                "분리형 눈썹칼의 경우, 칼날은 위탁 수하물로 반입해야 함"
            ]
        ),
        BaggageItem(
            classLabel: "휴대폰",
            checkedBaggage: .available,
            carryOnBaggage: .available,
            policyName: "전자기기",
            policyItems: [
                "휴대폰은 기내 휴대 가능",
                "배터리 용량이 160Wh 이하인 경우에만 허용"
            ]
        ),
        BaggageItem(
            classLabel: "볼펜",
            checkedBaggage: .available,
            carryOnBaggage: .available,
            policyName: "일반 물품",
            policyItems: [
                "볼펜은 기내 반입 및 위탁 가능"
            ]
        ),
    ]

    let baggageClassifier = try! BaggageClassifier()
    func classifyImage(image: UIImage) -> BaggageItem {
        let image = try! baggageClassifier.prediction(input: BaggageClassifierInput(sequential_1_inputWith: image.cgImage!))
        for item in baggageItems {
            if item.classLabel == image.classLabel {
                return item
            }
        }
        print("이미지 분류 실패")
        return baggageItems[0]
    }
}
