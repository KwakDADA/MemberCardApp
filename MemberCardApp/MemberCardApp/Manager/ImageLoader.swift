//
//  ImageLoader.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    
    private init() {}
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) -> Void {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return 
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async { completion(image) }
            } else {
                DispatchQueue.main.async { completion(nil) }
            }
        }
        
        task.resume()
    }
}
