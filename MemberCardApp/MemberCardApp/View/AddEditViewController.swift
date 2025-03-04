//
//  AddEditViewController.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import UIKit

final class AddEditViewController: UIViewController {
    private let addEditView = AddEditView()
    
    override func loadView() {
        view = addEditView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        addEditView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc func addButtonTapped() {
        print("저장 버튼 터치")
    }
}
