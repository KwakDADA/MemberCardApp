//
//  DetailViewController2.swift
//  MemberCardApp
//
//  Created by 권순욱 on 3/4/25.
//

import UIKit

class DetailViewController2: UIViewController {

    let member: Member
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    init(member: Member) {
        self.member = member
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController2: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let totalHeight = view.frame.height
//        switch indexPath.section {
//        case 0: return totalHeight * 1 / 9  // 버튼 영역 (1/9 비율)
//        case 1: return totalHeight * 4 / 9  // 이미지 영역 (4/9 비율)
//        case 2: return totalHeight * 4 / 9  // 레이블 영역 (4/9 비율)
//        default: return 0
//        }
        
        switch indexPath.section {
        case 0: return 50
        case 1: return 300
        case 2: return 300
        default: return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            let deleteButton = makeButton(title: "삭제")
            let editButton = makeButton(title: "편집")
            
            let spacer = UIView()
            let buttonStackView = UIStackView(arrangedSubviews: [spacer, deleteButton, editButton])
            buttonStackView.axis = .horizontal
            buttonStackView.alignment = .trailing
            buttonStackView.spacing = 8
            buttonStackView.translatesAutoresizingMaskIntoConstraints = false
            
            cell.contentView.addSubview(buttonStackView)
            
            NSLayoutConstraint.activate([
                buttonStackView.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                buttonStackView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                buttonStackView.widthAnchor.constraint(equalTo: cell.contentView.widthAnchor, multiplier: 0.5)
            ])
        case 1:
            let imageView = UIImageView(image: UIImage(systemName: "photo"))
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            cell.contentView.addSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                imageView.widthAnchor.constraint(equalTo: cell.contentView.widthAnchor, multiplier: 0.5),
                imageView.heightAnchor.constraint(equalTo: cell.contentView.heightAnchor, multiplier: 0.5)
            ])
        case 2:
//            let nameLabel = makeLabel(title: "이름")
//            let contentLabel = makeLabel(title: "내용")
//            let memberName: UILabel = {
//                let label = UILabel()
//                label.text = member.name
//                return label
//            }()
//            let contentLabelText: UILabel = {
//                let label = UILabel()
//                label.text = member.content
//                label.numberOfLines = 0
//                return label
//            }()
//            
//            // 내용1(이름) 스택 뷰
//            let content1StackView = UIStackView(arrangedSubviews: [nameLabel, memberName])
//            content1StackView.axis = .vertical
//            content1StackView.spacing = 4
//            
//            // 내용2(실제 내용) 스택 뷰
//            let content2StackView = UIStackView(arrangedSubviews: [contentLabel, contentLabelText])
//            content2StackView.axis = .vertical
//            content2StackView.spacing = 4
//            
//            // 내용 전체 스택 뷰(이름, 내용)
//            let contentsStackViewSpacer = UIView()
//            let contentsStackView = UIStackView(arrangedSubviews: [content1StackView, content2StackView, contentsStackViewSpacer])
//            contentsStackView.axis = .vertical
//            contentsStackView.spacing = 8
//            
//            cell.contentView.addSubview(contentsStackView)
//            NSLayoutConstraint.activate([
//                contentsStackView.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
//                contentsStackView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
//                contentsStackView.widthAnchor.constraint(equalTo: cell.contentView.widthAnchor, multiplier: 0.8)
//            ])
            
            
            
            // 4개의 레이블 (제목 + 내용)
            let titleLabel1 = UILabel()
            titleLabel1.text = "이름"
            titleLabel1.font = UIFont.boldSystemFont(ofSize: 16)  // 제목은 굵게
            
            let contentLabel1 = UILabel()
            contentLabel1.text = member.name
            contentLabel1.font = UIFont.systemFont(ofSize: 14)
            
            let titleLabel2 = UILabel()
            titleLabel2.text = "내용"
            titleLabel2.font = UIFont.boldSystemFont(ofSize: 16)
            
            let contentLabel2 = UILabel()
            contentLabel2.text = member.content
            contentLabel2.font = UIFont.systemFont(ofSize: 14)
            
            let labelStackView = UIStackView(arrangedSubviews: [titleLabel1, contentLabel1, titleLabel2, contentLabel2])
            labelStackView.axis = .vertical
            labelStackView.spacing = 8
            labelStackView.alignment = .leading
            labelStackView.translatesAutoresizingMaskIntoConstraints = false
            
            cell.contentView.addSubview(labelStackView)
            NSLayoutConstraint.activate([
                labelStackView.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                labelStackView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                labelStackView.widthAnchor.constraint(equalTo: cell.contentView.widthAnchor, multiplier: 0.8)
            ])
            
        default:
            break
        }
        
        return cell
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
