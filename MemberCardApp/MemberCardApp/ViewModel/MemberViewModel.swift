//
//  MemberViewModel.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import Foundation

class MemberViewModel {
    
    private let useCase = MemberUseCase()
    
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
            var updateData = UpdateMemberData(name: name, imageURL: imageURL, content: content)

            if let name = name { updateData.name = name }
            if let imageURL = imageURL { updateData.imageURL = imageURL }
            if let content = content { updateData.content = content }
            
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
