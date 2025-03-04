//
//  UserDefaultsRepository.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import Foundation

class MemberRepository {
    func getMembers() async -> [Member] {
        do {
            let users: [Member] = try await SupabaseManager.shared.client
                .from("members")
                .select()
                .execute()
                .value
            print("유저 목록: \(users)")
            return users
            
        } catch {
            print("데이터 가져오기 실패: \(error)")
            return []
        }
    }
    
    func addMember(name: String, imageURL: String, content: String) async {
        let newUser = ["name": name, "imageURL": imageURL, "content": content]
        
        do {
            try await SupabaseManager.shared.client
                .from("members")
                .insert(newUser)
                .execute()
            
            print("유저 추가 성공")
        } catch {
            print("유저 추가 실패: \(error)")
        }
    }
    
    func updateMember(id: UUID, data: UpdateMemberData) async {
        do {
            try await SupabaseManager.shared.client
                .from("members")
                .update(data)
                .eq("id", value: id.uuidString)
                .execute()
            
            print("유저 정보 수정 성공")
        } catch {
            print("유저 정보 수정 실패: \(error)")
        }
    }
    
    func deleteMember(id: UUID) async {
        do {
            try await SupabaseManager.shared.client
                .from("members")
                .delete()
                .eq("id", value: id.uuidString)
                .execute()
            
            print("유저 삭제 성공")
        } catch {
            print("유저 삭제 실패: \(error)")
        }
    }
}

