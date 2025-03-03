//
//  MemberViewModel.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import Foundation

class MemberViewModel {
    
    var onMembersUpdated: (()->Void)?
    
    private var users: [Member] = []
    private let repository = MemberRepository()
    
    func getMembers() async -> [Member] {
        let user = await repository.getMembers()
        onMembersUpdated?()
        return user
    }
    
    func addMember(name: String, imageURL: String, content: String) async {
        await repository.addMember(name: name, imageURL: imageURL, content: content)
        onMembersUpdated?()
    }
    
    func updateMember(id: UUID, name: String?, imageURL: String?, content: String?) async {
        
        var updateData = UpdateMemberData(name: name, imageURL: imageURL, content: content)

        if var name = name { updateData.name = name }
        if var imageURL = imageURL { updateData.imageURL = imageURL }
        if var content = content { updateData.content = content }

        await repository.updateMember(id: id, data: updateData)
    }
    
    func deleteMember(id: UUID) async {
        await repository.deleteMember(id: id)
        onMembersUpdated?()
    }
}
