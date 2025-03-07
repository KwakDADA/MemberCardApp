//
//  AddEditViewController.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import UIKit

final class AddEditViewController: UIViewController {
    // AddEditView 인스턴스 생성
    private let addEditView = AddEditView()
    
    // 이미지 선택 및 업로드를 위한 뷰 모델
    private let imagePickerViewModel = ImagePickerViewModel()
    // 회원 정보를 관리하는 뷰 모델
    private let viewModel: MemberViewModel
    
    init(member: Member, viewModel: MemberViewModel) {
        self.member = member
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    var member: Member
    
    // 선택한 프로필 이미지의 URL
    private var selectedImageURL: String?
    
    // 삭제 예정
    var editMode: Bool?
    
    // 스토리보드 X
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // AddEditView를 뷰로 설정
    override func loadView() {
        view = addEditView
    }
    
    // 뷰가 로드되면 UI 설정, 이미지 선택 기능 설정
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // 화면을 터치하면 키보드를 숨기기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // UI 설정 메서드
    private func setupUI() {
        // 내비게이션 바 우측에 addButton 설정
        let addButton = UIBarButtonItem(customView: addEditView.addButton)
        navigationItem.rightBarButtonItem = addButton
        
        // addButton 터치 이벤트
        addEditView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        // 프로필 이미지 터치 이벤트
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        addEditView.profileImageView.isUserInteractionEnabled = true
        addEditView.profileImageView.addGestureRecognizer(tapGesture)
        
        // 아래 코드는 변경 예정
        if !self.member.name.isEmpty || !self.member.imageURL.isEmpty || !self.member.content.isEmpty {
            loadImage(into: self.addEditView.profileImageView, from: self.member.imageURL)
            self.addEditView.nameTextField.text = self.member.name
            self.addEditView.contentTextView.text = self.member.content
            self.selectedImageURL = self.member.imageURL
            editMode = true
        }
    }
    
    // 이미지 뷰 터치 메서드
    @objc func imageViewTapped() {
        // 앨범에서 이미지 선택
        imagePickerViewModel.presentImagePicker(from: self)
        
        // 뷰 모델에 선언된 클로저 속성 이곳에 구현
        imagePickerViewModel.onImageUpload = { [weak self] imageURL in
            guard let self = self, let imageURL = imageURL else { return }
            // 선택한 이미지 주소 저장
            self.selectedImageURL = imageURL
            loadImage(into: self.addEditView.profileImageView, from: self.selectedImageURL!)
        }
    }
    
    @objc func addButtonTapped() {
        // 항목이 하나라도 비어있으면 알림
        guard let imageURL = self.selectedImageURL,
              let name = self.addEditView.nameTextField.text, !name.isEmpty,
              let content = self.addEditView.contentTextView.text, !content.isEmpty else {
            
            let alert = addEditView.createAlert(message: "빈칸을 채워주세요")
            present(alert, animated: true, completion: nil)
            return
        }
        
        // 기존에 멤버가 존재하면 업데이트, 아닐경우 새로 추가
        if editMode ?? false {
            viewModel.updateMember(id: self.member.id, name: name, imageURL: imageURL, content: content)
            // 바뀐 데이터 먼저 직접 전달
            NotificationCenter.default.post(name: NotificationName.editDone, object: Member(id: member.id, name: name, imageURL: imageURL, content: content))
        } else {
            viewModel.addMember(name: name, imageURL: imageURL, content: content)
        }
        // 이전 화면으로 이동
        self.navigationController?.popViewController(animated: true)
    }
}
