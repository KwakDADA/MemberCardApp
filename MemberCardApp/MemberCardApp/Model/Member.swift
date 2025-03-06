//
//  Member.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import Foundation

// Supabase에서 받아온 데이터를 JSON형식으로 변환하기 위해 Decodable을 채택하였다.
// UICollectionViewDiffableDataSource에서 아이템으로 사용하기 위해 Hashable을 채택하였다.
struct Member: Decodable, Hashable {
    let id: UUID
    let name: String
    let imageURL: String
    let content: String
}

// 데이터를 JSON 형식으로 변환하여 Supabase에 전송하기 위해 Encodable을 채택하였다.
struct UpdateMemberData: Encodable {
    var name: String?
    var imageURL: String?
    var content: String?
}
