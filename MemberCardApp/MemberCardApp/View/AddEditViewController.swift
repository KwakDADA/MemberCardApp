//
//  AddEditViewController.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import UIKit

final class AddEditViewController: UIViewController {
    private let addEditView = AddEditView()
    private let imagePickerViewModel = ImagePickerViewModel()
    
    override func loadView() {
        view = addEditView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupImagePicker()
    }
    
    private func setupUI() {
        addEditView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        addEditView.profileImageView.isUserInteractionEnabled = true
        addEditView.profileImageView.addGestureRecognizer(tapGesture)
    }
    
    private func setupImagePicker() {
        imagePickerViewModel.onImageUpload = { [weak self] imageURL in
            guard let self = self, let imageURL = imageURL else { return }
            
            if let url = URL(string: imageURL) {
                self.loadImage(from: url)
            }
        }
    }
    
    @objc func imageViewTapped() {
        imagePickerViewModel.presentImagePicker(from: self)
    }
    
    private func loadImage(from url: URL) {
        ImageLoader.shared.loadImage(from: url.absoluteString) { [weak self] image in
            guard let self = self else { return }
            self.addEditView.profileImageView.image = image
        }
    }
    
    @objc func addButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
