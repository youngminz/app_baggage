import SwiftUI

struct StartPageView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Text("우리만의 수하물 스캐너")
                .font(.custom("PoorStory-Regular", size: 18))
                .foregroundColor(Color(hex: "7C7C7C"))
            
            Text("수캐너")
                .font(.custom("PoorStory-Regular", size: 24))
                .foregroundColor(Color(hex: "7C7C7C"))
            
            Spacer()

            // 사진

            Spacer()

            // 시작하기 버튼

            Spacer()
        }
    }
}

#Preview {
    StartPageView()
}
