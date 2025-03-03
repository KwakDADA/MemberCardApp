//
//  ImagePickerViewModel.swift
//  MemberCardApp
//
//  Created by tlswo on 3/3/25.
//

import UIKit
import Storage

class ImagePickerViewModel: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let imagePicker = UIImagePickerController()
    var onImageUpload: ((String?) -> Void)?

    override init() {
        super.init()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
    }
    
    func presentImagePicker(from viewController: UIViewController) {
        viewController.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            print("선택된 이미지: \(selectedImage)")
            uploadImageToSupabase(selectedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func uploadImageToSupabase(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        
        let filePath = "uploads/\(UUID().uuidString).jpg"
        let bucketName = "Images" // Supabase Storage에서 만든 버킷 이름

        Task {
            do {
                try await SupabaseManager.shared.client.storage
                    .from(bucketName)
                    .upload(
                        filePath,
                        data: imageData,
                        options: FileOptions(contentType: "image/jpeg")
                    )

                let imageURL = "https://ngrfrnwbwnpdqwqisdbl.supabase.co/storage/v1/object/public/\(bucketName)/\(filePath)"
                DispatchQueue.main.async {
                    self.onImageUpload?(imageURL)
                }
                print("이미지 업로드 성공: \(imageURL)")
            } catch {
                DispatchQueue.main.async {
                    self.onImageUpload?(nil)
                }
                print("이미지 업로드 실패: \(error)")
            }
        }
    }
    
    
}
