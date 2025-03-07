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
        // 초기 fetchMembers 호출은 필요에 따라 변경
        Task {
            await fetchMembers()
        }
    }
    
    // async로 선언하여 호출한 쪽에서 기다릴 수 있도록 함
    func fetchMembers() async {
        let fetchedMembers = await repository.getMembers()
        memberStore.updateMembers(fetchedMembers)
        onMembersUpdated?(fetchedMembers)
    }
    
    func addMember(name: String, imageURL: String, content: String) {
        Task {
            await repository.addMember(name: name, imageURL: imageURL, content: content)
            await fetchMembers()
        }
    }
    
    func updateMember(id: UUID, name: String?, imageURL: String?, content: String?) {
        Task {
            let updateData = UpdateMemberData(name: name, imageURL: imageURL, content: content)
            await repository.updateMember(id: id, data: updateData)
            await fetchMembers()
        }
    }
    
    func deleteMember(id: UUID) {
        Task {
            await repository.deleteMember(id: id)
            await fetchMembers()
        }
    }
}
