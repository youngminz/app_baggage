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
    let baggageClassifier = try! BaggageClassifier()

    func classifyImage(image: UIImage) -> BaggageItem {
        let image = try! baggageClassifier.prediction(input: BaggageClassifierInput(sequential_9_inputWith: image.cgImage!))
        for item in baggageItems {
            if item.classLabel == image.classLabel {
                return item
            }
        }
        print("이미지 분류 실패")
        return baggageItems[0]
    }
    
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
                classLabel: "파운데이션",
                checkedBaggage: .available,
                carryOnBaggage: .conditional,
                policyName: "액체류",
                policyItems: [
                    "파운데이션은 액체, 젤, 크림, 페이스트 형태인 경우 100ml 이하의 개별 용기에 포장되어야 함",
                    "지퍼백에 담아야 하며, 총 허용량은 1L까지임"
                ]
            ),
            BaggageItem(
                classLabel: "라이터",
                checkedBaggage: .unavailable,
                carryOnBaggage: .conditional,
                policyName: "라이터",
                policyItems: [
                    "기내 반입만 허용하며 보안 검색대를 통과한 후 가지고 탑승해야 함",
                    "기내 수화물에는 금지"
                ]
            ),
            BaggageItem(
                classLabel: "보조배터리",
                checkedBaggage: .unavailable,
                carryOnBaggage: .available,
                policyName: "리튬 배터리",
                policyItems: [
                    "휴대용 충전기 또는 리튬 이온 배터리가 있는 보조배터리는 기내반입만 허용됨",
                    "100Wh 이하의 배터리는 제한 없이 휴대 가능",
                    "100Wh와 160Wh 사이인 경우 항공사 승인이 필요하며, 승객당 최대 2개까지 허용"
                ]
            ),
            BaggageItem(
                classLabel: "고데기",
                checkedBaggage: .conditional,
                carryOnBaggage: .available,
                policyName: "고데기",
                policyItems: [
                    "코드가 있는 전기 고데기는 배터리나 가스/연료 카트리지를 포함하지 않는 한 제한이 없음",
                    "무선 고데기(리튬 배터리 또는 부탄 카트리지로 작동)는 위탁 수하물에서 금지됨"
                ]
            ),
        BaggageItem(
            classLabel: "처방전",
            checkedBaggage: .available,
            carryOnBaggage: .available,
            policyName: "약",
            policyItems: [
                "액체 형태의 약은 합리적인 여행 수량에 대해 100ml를 초과하여 기내 반입 가능",
                "액체, 젤, 에어로졸 형태의 의료 필수품은 선언 후 검사를 받아야 함",
                "알약이나 기타 고체 형태의 약은 제한 없이 휴대 가능"
            ]
        ),
        BaggageItem(
            classLabel: "약봉지",
            checkedBaggage: .available,
            carryOnBaggage: .available,
            policyName: "약",
            policyItems: [
                "액체 형태의 약은 합리적인 여행 수량에 대해 100ml를 초과하여 기내 반입 가능",
                "액체, 젤, 에어로졸 형태의 의료 필수품은 선언 후 검사를 받아야 함",
                "알약이나 기타 고체 형태의 약은 제한 없이 휴대 가능"
            ]
        ),
        BaggageItem(
                classLabel: "즉석카레",
                checkedBaggage: .available,
                carryOnBaggage: .conditional,
                policyName: "음식",
                policyItems: [
                    "고체 음식물은 기내 및 위탁 수하물에 휴대 가능",
                    "즉석식품 중 액체류는 100ml 이하의 개별 용기에 포장되어야 함"
                ]
            ),
            BaggageItem(
                classLabel: "전자담배",
                checkedBaggage: .unavailable,
                carryOnBaggage: .available,
                policyName: "전자담배",
                policyItems: [
                    "기내 반입만 허용되며, 운반 시 가열 요소가 자동으로 작동하지 않도록 조치를 취해야 함",
                    "리튬 배터리가 없는 기기는 기내 및 위탁 수하물에 모두 허용됨",
                    "3-1-1 정책을 준수하는 경우에 한하여 담배와 관련된 액체를 기내 반입 허용"
                ]
            ),
            BaggageItem(
                classLabel: "노트북",
                checkedBaggage: .available,
                carryOnBaggage: .available,
                policyName: "노트북",
                policyItems: [
                    "리튬 또는 리튬 이온 배터리가 있는 기기는 기내 반입해야 함",
                    "보안 검색 시 노트북을 가방에서 꺼내 별도의 통에 넣어 엑스레이 검사를 받아야 함"
                ]
            ),
        BaggageItem(
           classLabel: "술",
           checkedBaggage: .available,
           carryOnBaggage: .conditional,
           policyName: "알코올 음료",
           policyItems: [
               "기내 반입 시 100ml 이하의 용기에 담긴 알코올 음료만 허용",
               "위탁 수하물의 경우, 24%-70%의 알코올 함량을 가진 음료는 승객 당 5리터까지 허용",
               "24% 이하의 알코올 음료는 위탁 수하물에서 제한이 없음"
           ]
       ),
       BaggageItem(
           classLabel: "손톱깎이",
           checkedBaggage: .available,
           carryOnBaggage: .available,
           policyName: "손톱깎이",
           policyItems: [
               "기내 및 위탁 수하물에 손톱깎이 휴대 가능",
               "날카로운 물건은 부상 방지를 위해 포장해야 함"
           ]
        ),
        BaggageItem(
            classLabel: "음료수",
            checkedBaggage: .available,
            carryOnBaggage: .conditional,
            policyName: "액체류",
            policyItems: [
                "기내 반입은 100ml 이하의 용기에 담긴 음료만 허용",
                "위탁 수하물에는 제한 없이 음료수를 휴대할 수 있음"
            ]
        ),
        BaggageItem(
            classLabel: "가위",
            checkedBaggage: .available,
            carryOnBaggage: .conditional,
            policyName: "가위",
            policyItems: [
                "기내 반입 시 가위의 날이 피봇 포인트로부터 4인치(약 10.16센티미터) 이하이어야 함",
                "4인치를 초과하는 가위는 위탁 수하물에만 허용됨",
                "날카로운 물건은 부상 방지를 위해 포장해야 함"
            ]
        ),
        BaggageItem(
            classLabel: "휴대폰",
            checkedBaggage: .available,
            carryOnBaggage: .available,
            policyName: "휴대폰",
            policyItems: [
                "기내 및 위탁 수하물에 휴대폰 휴대 가능"
            ]
        ),
        BaggageItem(
            classLabel: "눈썹칼",
            checkedBaggage: .available,
            carryOnBaggage: .conditional,
            policyName: "눈썹칼",
            policyItems: [
                "카트리지 눈썹칼은 기내 반입 허용되나, 블레이드가 보호되어야 함",
                "블레이드가 보호되지 않은 눈썹칼은 위탁 수하물에만 허용됨",
                "여분의 블레이드/카트리지는 기내 및 위탁 수하물에 모두 허용됨"
            ]
        ),
        BaggageItem(
            classLabel: "로션",
            checkedBaggage: .available,
            carryOnBaggage: .conditional,
            policyName: "로션",
            policyItems: [
                "기내 반입 시 로션은 100ml 이하의 용기에 담겨야 함",
                "100ml 이상의 통에 100ml 미만이 남은 경우 불가",
                "모든 액체류는 1리터 크기의 투명 지퍼백에 담아야 하며, 한 사람당 지퍼백 1개만 허용됨"
            ]
        ),
        BaggageItem(
            classLabel: "향수",
            checkedBaggage: .available,
            carryOnBaggage: .conditional,
            policyName: "향수",
            policyItems: [
                "기내 반입 시 향수는 100ml 이하의 용기에 담겨야 함",
                "모든 액체류는 1리터 크기의 투명 지퍼백에 담아야 하며, 한 사람당 지퍼백 1개만 허용됨",
                "위탁 수하물에는 제한된 의약품 및 화장품 아이템의 총량이 FAA 규정에 의해 제한됨"
            ]
        ),
    ]
}
