import SwiftUI

struct ResultPageView: View {
    @State var takenImage: UIImage
    @State var baggageItem: BaggageItem?
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
                        
                        Text(baggageItem?.classLabel ?? "분류 중...")
                            .font(.custom("Jua-Regular", size: 16))
                            .padding(.vertical, 15)
                    }
                }
                .border(Color(hex: "97CBEB"), width: 1)
                .padding(.all, 5)
                
                if (baggageItem != nil) {
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
                                        
                                        switch baggageItem?.checkedBaggage {
                                        case .available:
                                            Image("BaggageAllowedCircleIcon")
                                        case .conditional:
                                            Image("BaggageConditionalTriangleIcon")
                                        case .unavailable:
                                            Image("BaggageNotAllowedCrossIcon")
                                        default:
                                            Image("BaggageAllowedCircleIcon")
                                        }
                                        
                                        Spacer()
                                        
                                        switch baggageItem?.carryOnBaggage {
                                        case .available:
                                            Image("BaggageAllowedCircleIcon")
                                        case .conditional:
                                            Image("BaggageConditionalTriangleIcon")
                                        case .unavailable:
                                            Image("BaggageNotAllowedCrossIcon")
                                        default:
                                            Image("BaggageAllowedCircleIcon")
                                        }
                                        
                                        Spacer()
                                    }
                                    
                                    Spacer()
                                        .frame(height: 65)

                                    VStack(alignment: .leading) {
                                        Text(baggageItem?.policyName ?? "")
                                            .font(.custom("Jua-Regular", size: 30))
                                            .foregroundColor(Color(hex: "4F4F4F"))

                                            Spacer()
                                                .frame(height: 30)
                                        
                                        BulletList(
                                            listItems: baggageItem?.policyItems ?? [],
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
            
            if (baggageItem == nil) {
                ProgressView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1" {
                DispatchQueue.main.async(qos: .userInitiated) {
                    baggageItem = mainViewModel.classifyImage(image: takenImage)
                }
            }
        }
    }
}

#Preview {
    ResultPageView(
        takenImage: UIImage(),
        baggageItem: MainViewModel().baggageItems[0],
        mainViewModel: MainViewModel()
    )
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
