//
//  MemberViewModel.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import Foundation

class MemberViewModel {
    static let shared = MemberViewModel()
    
    private let repository: MemberRepository

    init(repository: MemberRepository = MemberRepository()) {
        self.repository = repository
    }
    
    // 뷰 업데이트를 위한 클로저
    var onMembersUpdated: (([Member])->Void)?
    
    private(set) var members: [Member] = []
    
    func fetchMembers() {
        Task {
            self.members = await repository.getMembers()
            onMembersUpdated?(self.members) // members 데이터 변경후 뷰 업데이트 클로저 실행
        }
    }
    
    func addMember(name: String, imageURL: String, content: String) {
        Task {
            await repository.addMember(name: name, imageURL: imageURL, content: content)
            fetchMembers()
        }
    }
    
    func updateMember(id: UUID, name: String?, imageURL: String?, content: String?) {
        Task {
            let updateData = UpdateMemberData(name: name, imageURL: imageURL, content: content)
            await repository.updateMember(id: id, data: updateData)
            fetchMembers()
        }
    }
    
    func deleteMember(id: UUID) {
        Task {
            await repository.deleteMember(id: id)
            fetchMembers()
        }
    }
}
