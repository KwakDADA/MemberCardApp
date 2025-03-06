//
//  MemberViewModel.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import Foundation

class MemberStore {
    static let shared = MemberStore()
    
    private init() {}
    
    private(set) var members: [Member] = []
    
    func updateMembers(_ members: [Member]) {
        self.members = members
    }
}

class MemberViewModel {
    private let repository: MemberRepository
    private let memberStore = MemberStore.shared
    
    var members: [Member] {
         return memberStore.members
     }

    var onMembersUpdated: (([Member]) -> Void)?

    init(repository: MemberRepository = MemberRepository()) {
        self.repository = repository
        fetchMembers()
    }
    
    func fetchMembers() {
        Task {
            let fetchedMembers = await repository.getMembers()
            await MainActor.run {
                memberStore.updateMembers(fetchedMembers)
                onMembersUpdated?(fetchedMembers)
            }
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
