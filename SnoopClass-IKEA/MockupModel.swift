//
//  MockupModel.swift
//  SnoopClass-IKEA
//
//  Created by Hyorim Nam on 2022/10/02.
//
// This file was generated from JSON Schema using quicktype then modified.

import Foundation

// MARK: - Ikea
struct Ikea: Codable {
    let recent, category: CompactCard
    let campaign, popular: DetailCard
}

// MARK: - DetailCard
struct DetailCard: Codable, Hashable {
    let title, button: String
    let items: [DetailItem]
    // hashable
    var id = UUID()
    static func == (lhs: DetailCard, rhs: DetailCard) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - DetailItem
struct DetailItem: Codable {
    let name, image, text: String
    let purchase: Purchase?
}

// MARK: - Purchase
struct Purchase: Codable {
    let price: Int
    let highlight: Bool
    let bundle: Int?
    let option: String?
}

// MARK: - CompactCard
struct CompactCard: Codable, Hashable {
    let title, button: String
    let items: [CompactItem]
    //hashable
    var id = UUID()
    static func == (lhs: CompactCard, rhs: CompactCard) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - CompactItem
struct CompactItem: Codable {
    let name, image: String
}
