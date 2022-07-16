//
//  TransactionModel.swift
//  Tickets
//
//  Created by andrey rulev on 16.07.2022.
//

import Foundation

struct TransactionModel {
    let sku: String
    let amount: String
    let currency: String
    
    init(sku: String,
         amount: String,
         currency: String) {
        self.sku = sku
        self.amount = amount
        self.currency = currency
    }
}

// MARK: Decodable

extension TransactionModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case sku
        case amount
        case currency
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let sku = try container.decode(String.self, forKey: .sku)
        let amount = try container.decode(String.self, forKey: .amount)
        let currency = try container.decode(String.self, forKey: .currency)
        self.init(sku: sku, amount: amount, currency: currency)
    }
}

