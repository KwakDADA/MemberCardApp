//
//  MemberUseCase.swift
//  MemberCardApp
//
//  Created by tlswo on 3/4/25.
//

import Foundation

class MemberUseCase {
    private let repository = MemberRepository()

    func getMembers() async -> [Member] {
        return await repository.getMembers()
    }
    
    func addMember(name: String, imageURL: String, content: String) async {
        await repository.addMember(name: name, imageURL: imageURL, content: content)
    }
    
    func updateMember(id: UUID, data: UpdateMemberData) async {
        await repository.updateMember(id: id, data: data)
    }
    
    func deleteMember(id: UUID) async {
        await repository.deleteMember(id: id)
    }
}
