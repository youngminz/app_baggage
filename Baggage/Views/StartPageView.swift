import SwiftUI

struct StartPageView: View {
    @State private var showImagePicker: Bool = false
    @State private var takenImage: UIImage = UIImage()
    @State private var showResultPage: Bool = false
    @StateObject var mainViewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: ResultPageView(
                        takenImage: takenImage,
                        mainViewModel: mainViewModel
                    ),
                    isActive: $showResultPage
                ) {
                    EmptyView()
                }
                
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
                    self.takenImage = image
                    self.showResultPage = true
                }
            })
        }
    }
}

#Preview {
    StartPageView()
}
