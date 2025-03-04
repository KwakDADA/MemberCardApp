//
//  AddMemberCell.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/4/25.
//

import UIKit

final class AddMemberCell: UICollectionViewCell {
    
    private let addImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "plus.circle.fill")
        imageView.tintColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setAddView()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = .gray
    }
    
    private func setAddView() {
        addSubview(addImageView)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            addImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            addImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            addImageView.heightAnchor.constraint(equalToConstant: 100),
            addImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
