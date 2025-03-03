//
//  MemberViewModel.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import Foundation

class MemberViewModel {
    private let repository: UserDefaultsRepository
    var onMembersUpdated: (() -> Void)?
    
    private var members: [Member] = [] {
        didSet {
            onMembersUpdated?()
        }
    }
    
    init(repository: UserDefaultsRepository = .shared){
        self.repository = repository
        self.members = repository.loadItems()
    }
    
    func getMembers() -> [Member]{
        return members
    }
    
    func getMember(withId id: Int) -> Member? {
        return members.first(where: { $0.id == id })
    }
    
    func addMember(name: String, imageURL: String, content: String) {
        let maxId = members.max(by: { $0.id < $1.id })?.id ?? 0
        let member = Member(id: maxId + 1, name: name, imageURL: imageURL, content: content)
        members.append(member)
        repository.saveItems(members)
        onMembersUpdated?()
    }
    
    func removeMember(withId id: Int){
        if let index = members.firstIndex(where: {$0.id == id}){
            members.remove(at: index)
            repository.saveItems(members)
            onMembersUpdated?()
        }
    }
    
    func editMember(widthId id: Int, name: String, imageURL: String, content: String){
        if let index = members.firstIndex(where: {$0.id == id}){
            members[index] = Member(id: id, name: name, imageURL: imageURL, content: content)
            repository.saveItems(members)
            onMembersUpdated?()
        }
    }
}
