//
//  MockupModel.swift
//  SnoopClass-IKEA
//
//  Created by Hyorim Nam on 2022/10/02.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.

// To parse the JSON, add this file to your project and do:
//
//   let ikea = try? newJSONDecoder().decode(Ikea.self, from: jsonData)

import Foundation

// MARK: - Ikea
struct Ikea: Codable {
    let recent, category: CompactCard
    let campaign, popular: DetailCard
}

// MARK: - DetailCard
struct DetailCard: Codable {
    let title, button: String
    let items: [DetailItem]
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
struct CompactCard: Codable {
    let title, button: String
    let items: [CompactItem]
}

// MARK: - CompactItem
struct CompactItem: Codable {
    let name, image: String
}
