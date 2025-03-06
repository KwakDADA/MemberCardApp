//
//  MemberCardAppTests.swift
//  MemberCardAppTests
//
//  Created by 곽다은 on 3/3/25.
//

import XCTest
@testable import MemberCardApp

class MockMemberRepository: MemberRepository {
    
    var mockMembers: [Member] = []
    
    override func getMembers() async -> [Member] {
        return mockMembers
    }
    
    override func addMember(name: String, imageURL: String, content: String) async {
        let newMember = Member(id: UUID(), name: name, imageURL: imageURL, content: content)
        mockMembers.append(newMember)
    }
    
    override func updateMember(id: UUID, data: UpdateMemberData) async {
        if let index = mockMembers.firstIndex(where: { $0.id == id }) {
            mockMembers[index] = Member(
                id: id,
                name: data.name ?? mockMembers[index].name,
                imageURL: data.imageURL ?? mockMembers[index].imageURL,
                content: data.content ?? mockMembers[index].content
            )
        }
    }
    
    override func deleteMember(id: UUID) async {
        mockMembers.removeAll { $0.id == id }
    }
}
