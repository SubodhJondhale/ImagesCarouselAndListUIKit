//
//  Page.swift
//  Demo App
//
//  Created by Subodh Jondhale on 30/07/24.
//

import Foundation

struct Page: Codable {
    let id: Int
    let image: String
    let items: [ListItem]
}
