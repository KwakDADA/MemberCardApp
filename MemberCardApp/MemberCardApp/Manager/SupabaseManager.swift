//
//  SupabaseManager.swift
//  MemberCardApp
//
//  Created by tlswo on 3/3/25.
//

import UIKit
import Supabase

class SupabaseManager {
    static let shared = SupabaseManager() // 싱글톤 패턴으로 전역에서 하나의 인스턴스만 존재하도록 보장
        
    private let supabaseUrl = URL(string: BaseURL.SUPABASE)! // Supabase 프로젝트의 URL
    private let supabaseAnonKey = Key.SUPABASE_ANON_KEY // Supabase 프로젝트의 익명키

    let client: SupabaseClient // Supabase와 통신(데이터베이스,스토리지)하기 위해 SupabaseClient 생성

    // 외부에서 새로운 인스턴스 생성 방지
    private init() {
        // SupabaseClient가 Supabase 프로젝트와 통신하기 위해 프로젝트의 URL과 익명키를 주고 초기화 시킴
        self.client = SupabaseClient(supabaseURL: supabaseUrl, supabaseKey: supabaseAnonKey)
    }
    
}
