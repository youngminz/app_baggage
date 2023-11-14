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

            Image("StartPageImage")

            Spacer()

            Image("StartPageButton")

            Spacer()
        }
    }
}

#Preview {
    StartPageView()
}
