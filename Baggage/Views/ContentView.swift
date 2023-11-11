import SwiftUI
import AVFoundation
import Vision

struct ContentView: View {
    @StateObject private var cameraProvider = CameraProvider()
    
    private let baggageClassifier = try! BaggageClassifier()

    var body: some View {
        VStack {
            CameraPreview(cameraProvider: cameraProvider)
                .onAppear {
                    cameraProvider.startSession()
                }
                .onDisappear {
                    cameraProvider.endSession()
                }
            
            if !cameraProvider.classificationResults.isEmpty {
                ForEach(cameraProvider.classificationResults, id: \.self) { result in
                    Text(result)
                }
            }
        }
    }
}

class CameraProvider: NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    private let session = AVCaptureSession()
    private let output = AVCaptureVideoDataOutput()
    private let queue = DispatchQueue(label: "camera-queue")
    private let baggageClassifier = try! BaggageClassifier()
    
    @Published var classificationResults: [String] = []
    
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override init() {
        super.init()
        self.previewLayer = AVCaptureVideoPreviewLayer(session: session) // 여기서 previewLayer를 초기화합니다.
        self.previewLayer.videoGravity = .resizeAspectFill // 비디오 콘텐츠가 뷰의 크기에 맞게 조정되도록 설정합니다.
        setupCamera()
    }
    
    func startSession() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.session.startRunning()
        }
    }
    
    func endSession() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.session.stopRunning()
        }
    }

    private func setupCamera() {
        guard let videoDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let videoInput = try? AVCaptureDeviceInput(device: videoDevice) else { return }

        session.beginConfiguration()
        if session.canAddInput(videoInput) {
            session.addInput(videoInput)
        }
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
        session.commitConfiguration()
        
        output.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String): Int(kCVPixelFormatType_32BGRA)]
        output.setSampleBufferDelegate(self, queue: queue)
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // This is called for each frame of the video
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        // CoreML 모델이 허용하는 이미지 크기로 조정
        let targetSize = CGSize(width: 224, height: 224) // 모델이 요구하는 크기로 변경
        let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        let imageRequest = try! VNCoreMLRequest(model: VNCoreMLModel(for: baggageClassifier.model), completionHandler: { [weak self] request, error in
            DispatchQueue.main.async {
                if let results = request.results as? [VNClassificationObservation] {
                    self?.classificationResults = results
                        .sorted(by: { $0.identifier < $1.identifier })
                        .map { "\($0.identifier): \(Int($0.confidence * 100))%" }
                }
            }
        })

        imageRequest.imageCropAndScaleOption = .centerCrop // 이미지의 가운데를 기준으로 크롭하고 크기 조정

        try! requestHandler.perform([imageRequest])
    }
    
//    private func classifyImage(_ buffer: CVPixelBuffer) {
//        let result = try! baggageClassifier.prediction(input: BaggageClassifierInput(sequential_7_input: buffer))
//        
//        DispatchQueue.main.async { [weak self] in
//            self?.classificationResults = result
//                .classLabel_probs
//                .map { "\($0.key): \(Int($0.value * 100))%" }
//                .s
//        }
//    }
}

struct CameraPreview: UIViewRepresentable {
    let cameraProvider: CameraProvider
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        cameraProvider.previewLayer.frame = view.bounds // 프리뷰 레이어의 프레임을 설정합니다.
        view.layer.addSublayer(cameraProvider.previewLayer) // 프리뷰 레이어를 추가합니다.
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        cameraProvider.previewLayer.frame = uiView.bounds // 뷰의 경계를 기준으로 프리뷰 레이어의 프레임을 업데이트합니다.
    }
}
