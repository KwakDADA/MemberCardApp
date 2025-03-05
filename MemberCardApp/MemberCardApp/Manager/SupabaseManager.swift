//
//  SupabaseManager.swift
//  MemberCardApp
//
//  Created by tlswo on 3/3/25.
//

import UIKit
import Supabase

class SupabaseManager {
    static let shared = SupabaseManager()
    
    private let supabaseUrl = URL(string: BaseURL.SUPABASE)!
    private let supabaseAnonKey = Key.SUPABASE_ANON_KEY

    let client: SupabaseClient

    private init() {
        self.client = SupabaseClient(supabaseURL: supabaseUrl, supabaseKey: supabaseAnonKey)
    }
    
}
