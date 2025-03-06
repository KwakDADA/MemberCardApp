//
//  ImageRepository.swift
//  MemberCardApp
//
//  Created by tlswo on 3/6/25.
//

import UIKit
import Storage

class ImageRepository {
    func uploadImage(_ image: UIImage) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return nil }

        let filePath = "uploads/\(UUID().uuidString).jpg"
        let bucketName = "Images"

        // Supabase에 이미지 업로드하고 이미지에 대한 URL 생성후 반환, 실패시 nil 반환
        do {
            try await SupabaseManager.shared.client.storage
                .from(bucketName)
                .upload(
                    filePath,
                    data: imageData,
                    options: FileOptions(contentType: "image/jpeg")
                )

            let imageURL = "\(BaseURL.SUPABASE)/storage/v1/object/public/\(bucketName)/\(filePath)"
            return imageURL
        } catch {
            print("이미지 업로드 실패: \(error)")
            return nil
        }
    }
}
