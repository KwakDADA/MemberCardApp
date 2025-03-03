//
//  MainViewController.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import UIKit

final class MainViewController: UIViewController {
    
    let imagePickerViewModel = ImagePickerViewModel()
    
    let imageView = UIImageView()
    
    let button = UIButton()
    
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(button)
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.distribution = .equalSpacing
        
        button.setTitle("click", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.backgroundColor = .lightGray
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        imagePickerViewModel.onImageUpload = { [weak self] imageURL in
            guard let self = self else { return }
            DispatchQueue.main.async {
                guard let imageURL = imageURL else {
                    return
                }
                ImageLoader.shared.loadImage(from: imageURL) { image in
                    self.imageView.image = image
                }
            }
        }
    }
    
    @objc func didTapButton() {
        imagePickerViewModel.presentImagePicker(from: self)
    }
    
}

