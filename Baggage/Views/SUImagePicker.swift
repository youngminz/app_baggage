import SwiftUI

struct SUImagePicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController

    @Environment(\.presentationMode)
    private var presentationMode // 해당 뷰컨트롤러의 노출 여부
    let onImageTaken: (UIImage) -> () // 이미지가 선택 됐을때 결과 호출

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: SUImagePicker

        init(parent: SUImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.onImageTaken(image)
                parent.presentationMode.wrappedValue.dismiss()
            }
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()

        picker.delegate = context.coordinator
        picker.sourceType = .camera

        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }
}
