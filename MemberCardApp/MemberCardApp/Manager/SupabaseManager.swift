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
    
    private let supabaseUrl = URL(string: "https://ngrfrnwbwnpdqwqisdbl.supabase.co")!
    private let supabaseAnonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5ncmZybndid25wZHF3cWlzZGJsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA5ODYxMjEsImV4cCI6MjA1NjU2MjEyMX0.BUbX2pYVNysYmtAI5d6x9PV8Tg6oQVpBcXqKxfN6ZeA"

    let client: SupabaseClient

    private init() {
        self.client = SupabaseClient(supabaseURL: supabaseUrl, supabaseKey: supabaseAnonKey)
    }
    
}
