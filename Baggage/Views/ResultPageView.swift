import SwiftUI

struct ResultPageView: View {
    @State var takenImage: UIImage
    @StateObject var mainViewModel: MainViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
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

            ScrollView() {
                Text("촬영 시 한 화면에 하나의 물품만 나오게 촬영해주세요")
                    .font(.custom("Jua-Regular", size: 16))
                    .foregroundColor(Color(hex: "4F4F4F"))
                
                ZStack {
                    Color(hex: "F0F8FE")
                    
                    VStack {
                        Image(uiImage: takenImage)
                            .resizable()
                            .scaledToFit()
                        
                        Text("스프레이류")
                            .font(.custom("Jua-Regular", size: 16))
                            .padding(.vertical, 15)
                    }
                }
                .border(Color(hex: "97CBEB"), width: 2)
                .padding(.all, 5)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
        
}

#Preview {
    ResultPageView(takenImage: UIImage(), mainViewModel: MainViewModel())
}
