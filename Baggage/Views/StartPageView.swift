import SwiftUI

struct StartPageView: View {
    @State private var showImagePicker: Bool = false
    @State private var pickedImage: UIImage?
    
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

            Button(action: {
                self.showImagePicker = true
            }) {
                Image("StartPageButton")
            }

            Spacer()
        }
        .fullScreenCover(isPresented: $showImagePicker, content: {
            SUImagePicker { image in
                self.pickedImage = image
            }
        })
    }
}

#Preview {
    StartPageView()
}
