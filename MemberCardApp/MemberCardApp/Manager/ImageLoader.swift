//
//  ImageLoader.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import UIKit

class ImageLoader {
    static let shared = ImageLoader() // 싱글톤 패턴으로 전역에서 하나의 인스턴스만 존재하도록 보장
    
    private init() {} // 외부에서 새로운 인스턴스 생성 방지
    
    // 이미지URL을 비동기적으로 받아서 Completion Handler를 통해 UIImage 반환
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) -> Void {
        // 문자열을 URL 객체로 변환, 실패시 nil 반환
        guard let url = URL(string: urlString) else {
            completion(nil)
            return 
        }
        
        // 비동기적으로 이미지 다운로드
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // 정상적으로 다운로드 되면 UIImage를 생성후 반환
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async { completion(image) }
            } else {
                DispatchQueue.main.async { completion(nil) } // 실패시 nil 반환
            }
        }
        
        task.resume() // 다운로드 요청을 시작
    }
}
