//
//  UIViewController+.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/6/25.
//

import UIKit

extension UIViewController {
    func loadImage(into imageView: UIImageView, from urlString: String, placeholder: UIImage? = UIImage(systemName: "photo")) {
        let loader = ImageLoader()
        loader.loadImage(from: urlString) { image in
            DispatchQueue.main.async {
                imageView.image = image ?? placeholder
            }
        }
    }
}
