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
            classLabel: "눈썹칼",
            checkedBaggage: .available,
            carryOnBaggage: .conditional,
            policyName: "가위, 칼류",
            policyItems: [
                "무기로 사용될 가능성이 없는 감자 칼이나 날 길이 6cm 이하의 가위는 반입이 가능합니다.",
                "눈썹 칼은 무기로 사용될 소지가 없으므로 기내 반입이 가능합니다.",
                "단, 분리형일 경우 칼날은 위탁 수하물로 반입하셔야 합니다."
            ]
        ),
        BaggageItem(
            classLabel: "헤어스프레이",
            checkedBaggage: .available,
            carryOnBaggage: .conditional,
            policyName: "액체류",
            policyItems: [
                "음료, 식품, 화장품 등 액체류(스프레이) 및 젤류(젤 또는 크림) 물품",
                "콘택트렌즈 세척액",
                "개별 용기당 100ml 이하로 1인당 총 1L 용량의 비닐 지퍼백 1개",
                "액체류 음식류인 수프, 김치, 된장, 고추장, 홍삼정 같은 것도 액체로 보아 동일하게 100ml 이하로 1L 비닐 지퍼백에 담아 휴대 가능"
            ]
        ),
        BaggageItem(
            classLabel: "라이터",
            checkedBaggage: .available,
            carryOnBaggage: .conditional,
            policyName: "라이터 및 안전성냥",
            policyItems: [
                "1인당 1개 이하의 라이터 및 안전성냥",
                "중국 출발편 경우 휴대/위탁 모두 불가"
            ]
        ),
        BaggageItem(
            classLabel: "리뉴통 355ml",
            checkedBaggage: .available,
            carryOnBaggage: .conditional,
            policyName: "액체류",
            policyItems: [
                "음료, 식품, 화장품 등 액체류(스프레이) 및 젤류(젤 또는 크림) 물품",
                "콘택트렌즈 세척액",
                "개별 용기당 100ml 이하로 1인당 총 1L 용량의 비닐 지퍼백 1개",
                "액체류 음식류인 수프, 김치, 된장, 고추장, 홍삼정 같은 것도 액체로 보아 동일하게 100ml 이하로 1L 비닐 지퍼백에 담아 휴대 가능"
            ]
        ),
        BaggageItem(
            classLabel: "처방전",
            checkedBaggage: .available,
            carryOnBaggage: .available,
            policyName: "의약품",
            policyItems: [
                "여행 중 필요한 개인용 의약품",
                "의사가 처방한 의약품은 의사소견서 혹은 처방전 등을 제시할 수 있어야 함"
            ]
        ),
        BaggageItem(
            classLabel: "약봉지",
            checkedBaggage: .available,
            carryOnBaggage: .available,
            policyName: "의약품",
            policyItems: [
                "여행 중 필요한 개인용 의약품",
                "의사가 처방한 의약품은 의사소견서 혹은 처방전 등을 제시할 수 있어야 함"
            ]
        ),
        BaggageItem(
            classLabel: "고데기",
            checkedBaggage: .conditional,
            carryOnBaggage: .conditional,
            policyName: "전자기기",
            policyItems: [
                "배터리 분리가 불가한 헤어컬(고데기) 일본 출발편 한정 휴대/위탁 모두 불가",
                "배터리를 분리할 수 있으며 용량이 160Wh 이하인 경우는 배터리 분리 후 배터리는 휴대, 휠/가방 등은 휴대 또는 위탁 할 수 있습니다."
            ]
        ),
        BaggageItem(
            classLabel: "보조배터리",
            checkedBaggage: .unavailable,
            carryOnBaggage: .available,
            policyName: "보조/여분 리튬배터리",
            policyItems: [
                "배터리 용량이 160Wh 이하이며 단락 방지 포장된 여분/보조 배터리",
                "100Wh 이하 배터리 최대 20개+100Wh 초과 160Wh 이하 배터리 최대 2개 휴대 가능 (해외 출발편의 경우 공항/국가별 별도 강화된 규정 적용 가능)",
                "배터리 용량이 100Wh 이하인 전자담배",
                "기내에서 충전 및 사용은 엄격히 금지됩니다.",
                "배터리 용량이 상기 조건을 초과하거나 확인이 불가할 경우 운송이 거절될 수 있습니다. (위탁, 휴대 모두 불가)"
            ]
        ),
        BaggageItem(
            classLabel: "카레",
            checkedBaggage: .available,
            carryOnBaggage: .conditional,
            policyName: "액체류 음식",
            policyItems: [
                "액체류 음식류인 수프, 김치, 된장, 고추장, 홍삼정 같은 것도 액체로 보아 동일하게 100ml 이하로 1L 비닐 지퍼백에 담아 휴대 가능",
                "개별 용기당 100ml 이하로 1인당 총 1L 용량의 비닐 지퍼백 1개"
            ]
        ),
        BaggageItem(
            classLabel: "음료수",
            checkedBaggage: .available,
            carryOnBaggage: .conditional,
            policyName: "액체류",
            policyItems: [
                "개별 용기당 100ml 이하로 1인당 총 1L 용량의 비닐 지퍼백 1개에 담아 기내 반입이 가능합니다."
            ]
        ),
        BaggageItem(
            classLabel: "가위",
            checkedBaggage: .available,
            carryOnBaggage: .conditional,
            policyName: "가위, 칼류",
            policyItems: [
                "날 길이 6cm 이하의 가위는 기내 반입이 가능합니다.",
                "날이 긴 가위는 위탁 수하물로만 반입 가능합니다."
            ]
        ),
        BaggageItem(
            classLabel: "눈썹칼",
            checkedBaggage: .available,
            carryOnBaggage: .conditional,
            policyName: "가위, 칼류",
            policyItems: [
                "눈썹 칼은 무기로 사용될 소지가 없으므로 기내 반입이 가능합니다.",
                "단, 분리형일 경우 칼날은 위탁 수하물로 반입하셔야 합니다."
            ]
        ),
        BaggageItem(
            classLabel: "휴대폰",
            checkedBaggage: .available,
            carryOnBaggage: .available,
            policyName: "전자기기",
            policyItems: [
                "여객기로 운송 가능한 휴대용 전자기기는 기내 휴대가 가능합니다.",
                "배터리 용량이 160Wh 이하인 휴대폰은 기내에 휴대 가능합니다."
            ]
        ),
        BaggageItem(
            classLabel: "볼펜",
            checkedBaggage: .available,
            carryOnBaggage: .available,
            policyName: "일반 물품",
            policyItems: [
                "일반적인 사무용품은 기내 반입 및 위탁이 가능합니다."
            ]
        )
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
