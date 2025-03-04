//
//  MemberViewModel.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import Foundation

class MemberViewModel {
    static let shared = MemberViewModel()
    
    private var useCase = MemberUseCase()
    
    init(useCase: MemberUseCase = MemberUseCase()) {
        self.useCase = useCase
    }
    
    var onMembersUpdated: (([Member])->Void)?
    
    private(set) var members: [Member] = []
    
    func fetchMembers() {
        Task {
            self.members = await useCase.getMembers()
            onMembersUpdated?(self.members)
        }
    }
    
    func addMember(name: String, imageURL: String, content: String) {
        Task {
            await useCase.addMember(name: name, imageURL: imageURL, content: content)
            fetchMembers()
        }
    }
    
    func updateMember(id: UUID, name: String?, imageURL: String?, content: String?) {
        Task {
            let updateData = UpdateMemberData(name: name, imageURL: imageURL, content: content)
            await useCase.updateMember(id: id, data: updateData)
            fetchMembers()
        }
    }
    
    func deleteMember(id: UUID) {
        Task {
            await useCase.deleteMember(id: id)
            fetchMembers()
        }
    }
}
