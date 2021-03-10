//
//  Model.swift
//  SwiftUI-MVVM
//
//  Created by Nick on 3/10/21.
//

import Foundation

struct PetResult: Codable {
    let rs: String
    let data: [PetPriceModel]
    enum CodingKeys: String, CodingKey {
        case rs = "RS"
        case data = "Data"
    }
}

struct PetPriceModel: Codable, Hashable, Identifiable {
    var id: Int { hashValue }
    
    let transDate: String
    let marketName: String
    let transNumAvgPrice: Double
    
    enum CodingKeys: String, CodingKey {
        case transDate = "TransDate"
        case marketName = "MarketName"
        case transNumAvgPrice = "TransNum_AvgPrice"
    }
}

