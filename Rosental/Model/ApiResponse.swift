//
//  CustomerDashboard.swift
//  Rosental
//
//  Created by Артем Петрюк on 02.09.2024.
//

import Foundation

/// Root structure
struct ApiResponse: Decodable {
    let customerDashboard: CustomerDashboard
    let myProfile: MyProfile
    let myNewNotifications: Int
    let code: Int
}

/// Customer Dashboard Structure
struct CustomerDashboard: Decodable {
    let date: String
    let notifications: Notifications
    let menuItems: [MenuItem]
    let banners: [Banner]
    let services: [Service]
    let navbar: [NavbarItem]
}

/// Profile structure
struct MyProfile: Decodable {
    let id: String
    let name: String
    let shortName: String
    let firstName: String
    let lastName: String
    let secondName: String
    let email: String
    let phone: String
    let photo: String
    let property: String
    let address: String
    let rating: Int
}

/// Notifications structure
struct Notifications: Decodable {
    let count: Int
}

/// Menu Item structure
struct MenuItem: Decodable {
    let action: String
    let name: String
    let description: String
    let arrear: String?
    let amountCoins: Int?
    let expected: Expected?
}

/// Expected structure
struct Expected: Decodable {
    let lastDate: String
    let indications: [Indication]
}

/// Indication structure
struct Indication: Decodable {
    let type: String
    let label: String
    let lastTransfer: String
    let expected: Bool
}

/// Banner structure
struct Banner: Decodable {
    let title: String
    let text: String
    let image: String
    let action: String
    let priority: Int
}

/// Service structure
struct Service: Decodable {
    let name: String
    let action: String
    let order: Int
}

/// Navbar item structure
struct NavbarItem: Decodable {
    let name: String
    let action: String
}
