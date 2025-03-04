//
//  Member.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import Foundation

struct Member: Codable, Hashable {
    let id: UUID
    let name: String
    let imageURL: String
    let content: String
}

struct UpdateMemberData: Encodable {
    var name: String?
    var imageURL: String?
    var content: String?
}
