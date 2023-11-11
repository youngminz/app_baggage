import SwiftUI
import Vision
import UIKit

struct ContentView: View {
    @State private var showImagePicker: Bool = false
    @State private var pickedImage: UIImage?
    @State private var classificationResults: [String] = []
    
    private let baggageClassifier = try! BaggageClassifier()
    
    var body: some View {
        VStack {
            if let inputImage = pickedImage {
                Image(uiImage: inputImage)
                    .resizable()
                    .scaledToFit()
            }
            
            if !classificationResults.isEmpty {
                ForEach(classificationResults, id: \.self) { result in
                    Text(result)
                }
            }
            
            Button("Take a Picture") {
                self.showImagePicker = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            // Any other content
        }
        .sheet(isPresented: $showImagePicker) {
            SUImagePicker() { image in
                self.pickedImage = image
                classifyImage(image)
            }
        }
    }
    
    private func classifyImage(_ image: UIImage) {
        let result = try! baggageClassifier.prediction(input: BaggageClassifierInput(sequential_7_inputWith: image.cgImage!))
        print(result.classLabel)
        
        classificationResults = result.classLabel_probs.sorted(by: { $0.value > $1.value }).map { "\($0.key): \(Int($0.value * 100))%" }
        
    }
}
