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

#if DEBUG
extension Member {
    static let sampleData: [Member] = [
        .init(id: UUID(), name: "김민준", imageURL: "https://i.pinimg.com/originals/66/66/66/6666666666666666_1280.jpg", content: """
1. [자신]에 대한 설명 및 MBTI
2. 객관적으로 살펴본 자신의 장점
3. 자신의 스타일 협업 스타일 소개
4. 블로그 주소
"""),
    ]
    
    static let sample = sampleData[0]
}
#endif
