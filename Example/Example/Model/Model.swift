//
//  Model.swift
//  Example
//
//  Created by Hiral Naik on 7/28/25.
//

import Foundation

struct User: Codable {
    let id: Int?
    let name: String?
    let company: String?
    let username: String?
    let email: String?
    let address: String?
    let zip: String?
    let state: String?
    let country: String?
    let phone: String?
    let photo: String?
}
