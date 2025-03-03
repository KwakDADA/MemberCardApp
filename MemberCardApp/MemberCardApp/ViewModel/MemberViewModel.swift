//
//  MemberViewModel.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import Foundation

class MemberViewModel {
    
    var onMembersUpdated: (()->Void)?
    
    private var members: [Member] = [] {
        didSet {
            onMembersUpdated?()
        }
    }
    
    private let repository = MemberRepository()
    
    func getMembers() async -> [Member] {
        let members = await repository.getMembers()
        onMembersUpdated?()
        return members
    }
    
    func addMember(name: String, imageURL: String, content: String) async {
        await repository.addMember(name: name, imageURL: imageURL, content: content)
        onMembersUpdated?()
    }
    
    func updateMember(id: UUID, name: String?, imageURL: String?, content: String?) async {
        
        var updateData = UpdateMemberData(name: name, imageURL: imageURL, content: content)

        if let name = name { updateData.name = name }
        if let imageURL = imageURL { updateData.imageURL = imageURL }
        if let content = content { updateData.content = content }

        await repository.updateMember(id: id, data: updateData)
    }
    
    func deleteMember(id: UUID) async {
        await repository.deleteMember(id: id)
        onMembersUpdated?()
    }
}
