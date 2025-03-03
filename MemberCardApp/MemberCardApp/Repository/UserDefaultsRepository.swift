//
//  UserDefaultsRepository.swift
//  MemberCardApp
//
//  Created by 곽다은 on 3/3/25.
//

import Foundation

class UserDefaultsRepository {
    static let shared = UserDefaultsRepository()
    
    private let userDefaults = UserDefaults.standard
    private let itemsKey = "items"

    func saveItems(_ items: [Member]) {
        userDefaults.set(items, forKey: itemsKey)
    }

    func loadItems() -> [Member] {
        return userDefaults.array(forKey: itemsKey) as? [Member] ?? []
    }
}
