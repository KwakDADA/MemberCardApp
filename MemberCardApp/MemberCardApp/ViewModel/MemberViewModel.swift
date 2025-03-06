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

    private(set) var members: [Member] = [] {
        didSet {
            onMembersUpdated?(members)
        }
    }
    
    var onMembersUpdated: (([Member]) -> Void)?
    
    func updateMembers(_ newMembers: [Member]) {
        self.members = newMembers
    }
}

class MemberViewModel {
    private let repository: MemberRepository
    private var store = MemberStore.shared
    
    var onMembersUpdated: (([Member]) -> Void)?

    init(repository: MemberRepository = MemberRepository()) {
        self.repository = repository
        store.onMembersUpdated = { [weak self] updatedMembers in
            self?.onMembersUpdated?(updatedMembers)
        }
    }

    var members: [Member] {
        return store.members
    }

    func fetchMembers() {
        Task {
            let fetchedMembers = await repository.getMembers()
            store.updateMembers(fetchedMembers)
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

