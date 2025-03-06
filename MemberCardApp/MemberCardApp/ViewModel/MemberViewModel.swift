//
//  MemberViewModel.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import Foundation

class MemberViewModel {
    private let repository: MemberRepository

    private(set) var members: [Member] = [] {
        didSet {
            onMembersUpdated?(members)
        }
    }

    var onMembersUpdated: (([Member]) -> Void)?

    init(repository: MemberRepository = MemberRepository()) {
        self.repository = repository
    }

    
    func fetchMembers() {
        Task {
            self.members = await repository.getMembers()
            onMembersUpdated?(self.members)
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
