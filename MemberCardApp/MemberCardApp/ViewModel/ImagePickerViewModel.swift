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

    private let repository: ImageRepository

    init(repository: ImageRepository = ImageRepository()) {
         self.repository = repository
         super.init()
         setupImagePicker()
    }
    
    private func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
    }
    
    // 엘범 보여주기
    func presentImagePicker(from viewController: UIViewController) {
        viewController.present(imagePicker, animated: true, completion: nil)
    }
    
    // 엘범에서 사진을 선택했을때에 대한 이벤트 처리(이미지 업로드)
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            print("선택된 이미지: \(selectedImage)")
            uploadImage(selectedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // 이미지 업로드 메서드 
    func uploadImage(_ image: UIImage) {
        Task {
            let imageURL = try? await repository.uploadImage(image)
            DispatchQueue.main.async {
                self.onImageUpload?(imageURL)
            }
        }
    }
}
