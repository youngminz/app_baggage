import SwiftUI

struct StartPageView: View {
    var body: some View {
        VStack {
            Text("우리만의 수하물 스캐너")
                .font(.custom("PoorStory-Regular", size: 18))
            
            Text("수캐너")
                .font(.custom("PoorStory-Regular", size: 24))
        }
    }
}

#Preview {
    StartPageView()
}
