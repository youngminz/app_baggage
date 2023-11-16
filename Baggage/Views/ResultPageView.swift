import SwiftUI

struct ResultPageView: View {
    @State var takenImage: UIImage
    @StateObject var mainViewModel: MainViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            ScrollView() {
                Spacer()
                    .frame(height: 60)
                
                Text("촬영 시 한 화면에 하나의 물품만 나오게 촬영해주세요")
                    .font(.custom("Jua-Regular", size: 16))
                    .foregroundColor(Color(hex: "4F4F4F"))
                
                ZStack {
                    Color(hex: "F0F8FE")
                    
                    VStack {
                        Image(uiImage: takenImage)
                            .resizable()
                            .scaledToFit()
                            .padding(.all, 10)
                        
                        Text("스프레이류")
                            .font(.custom("Jua-Regular", size: 16))
                            .padding(.vertical, 15)
                    }
                }
                .border(Color(hex: "97CBEB"), width: 1)
                .padding(.all, 5)
                
                Spacer()
                    .frame(height: 20)
                
                ZStack {
                    Color(hex: "B0D6ED")
                    ZStack {
                        Color(hex: "FFFFFF")
                        ZStack {
                            Color(hex: "F0F8FE")
                            Image("ResultPageImage")
                            VStack {
                                Spacer()
                                    .frame(height: 10)
                                
                                HStack {
                                    Spacer()

                                    Text("위탁")
                                        .font(.custom("Jua-Regular", size: 16))
                                        .foregroundColor(Color(hex: "4F4F4F"))

                                    Spacer()

                                    Text("기내")
                                        .font(.custom("Jua-Regular", size: 16))
                                        .foregroundColor(Color(hex: "4F4F4F"))

                                    Spacer()
                                }
                                
                                HStack {
                                    Spacer()
                                    Image("BaggageAllowedCircleIcon")
                                    Spacer()
                                    Image("BaggageConditionalTriangleIcon")
                                    Spacer()
                                }
                                
                                Spacer()
                                    .frame(height: 65)

                                VStack(alignment: .leading) {
                                    Text("액체류")
                                        .font(.custom("Jua-Regular", size: 30))
                                        .foregroundColor(Color(hex: "4F4F4F"))

                                        Spacer()
                                            .frame(height: 30)
                                    
                                    BulletList(
                                        listItems: [
                                            "음료, 식품, 화장품 등 액체류(스프레이) 및 젤류(젤 또는 크림) 물품",
                                            "컨텍트렌즈 세척액",
                                            "개별 용기당 100ml 이하로 1인당 총 1L 용량의 비닐 지퍼백 1개",
                                            "액체류 음식류인 수프, 김치, 된장, 고추장, 홍삼정 같은 것도 액체로 보아 동일하게 100ml 이하로 1L 비닐 지퍼팩에 담아 휴대 가능"
                                        ],
                                        listItemSpacing: 30,
                                        bulletWidth: 20
                                    )
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 35)
                                
                                Spacer()
                                    .frame(height: 75)
                                

                                Button(action: {
                                    dismiss()
                                }) {
                                    Image("ResultPageButton")
                                }
                                
                                Spacer()
                                    .frame(height: 30)
                            }
                        }
                        .cornerRadius(30.0)
                        .padding(.all, 5)
                    }
                    .cornerRadius(30.0)
                    .padding(.all, 13)

                }
                .cornerRadius(30.0)
            }
            
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image("NavigationBarBackButton")
                    }
                    .padding(.leading, 10)

                    Spacer()
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
        
}

#Preview {
    ResultPageView(takenImage: UIImage(), mainViewModel: MainViewModel())
}

struct BulletList: View {
    var listItems: [String]
    var listItemSpacing: CGFloat? = nil
    var bullet: String = "•"
    var bulletWidth: CGFloat? = nil
    var bulletAlignment: Alignment = .leading
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: listItemSpacing) {
            ForEach(listItems, id: \.self) { data in
                HStack(alignment: .top) {
                    Text(bullet)
                        .frame(width: bulletWidth,
                               alignment: bulletAlignment)
                        .font(.custom("Jua-Regular", size: 18))
                        .foregroundColor(Color(hex: "4F4F4F"))
                    Text(data)
                        .frame(maxWidth: .infinity,
                               alignment: .leading)
                        .font(.custom("Jua-Regular", size: 18))
                        .foregroundColor(Color(hex: "4F4F4F"))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}
