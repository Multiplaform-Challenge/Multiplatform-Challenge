//
//  ProductItem.swift
//  SwiftUITests
//
//  Created by José Mateus Azevedo on 14/05/21.
//

import SwiftUI

struct ProductItem: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var price: Float
    var itemNumber: Int
}
