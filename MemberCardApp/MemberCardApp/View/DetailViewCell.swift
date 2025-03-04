//
//  DetailViewCell.swift
//  MemberCardApp
//
//  Created by 권순욱 on 3/4/25.
//

import UIKit

class DetailViewCell: UITableViewCell {

    let member: Member
    
    // 상단 버튼 2개
    private lazy var deleteButton = makeButton(title: "삭제")
    private lazy var editButton = makeButton(title: "편집")
    
    // 하단 내용의 레이블
    private lazy var nameLabel = makeLabel(title: "이름")
    private lazy var contentLabel = makeLabel(title: "내용")
    
    // 하단 실제 내용
    private lazy var memberName: UILabel = {
        let label = UILabel()
        label.text = member.name
        return label
    }()
    
    private lazy var contentLabelText: UILabel = {
        let label = UILabel()
        label.text = member.content
        label.numberOfLines = 0
        return label
    }()
    
    init(member: Member) {
        self.member = member
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func makeButton(title: String) -> UIButton {
        let button = UIButton(configuration: .tinted())
        button.setTitle(title, for: .normal)
        return button
    }
    
    private func makeLabel(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.backgroundColor = .orange
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }
    
    
}
