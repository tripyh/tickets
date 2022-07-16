//
//  RateModel.swift
//  Tickets
//
//  Created by andrey rulev on 16.07.2022.
//

import Foundation

struct RateModel {
    let from: String
    let to: String
    let rate: String
    
    init(from: String,
         to: String,
         rate: String) {
        self.from = from
        self.to = to
        self.rate = rate
    }
}

// MARK: Decodable

extension RateModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case from
        case to
        case rate
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let from = try container.decode(String.self, forKey: .from)
        let to = try container.decode(String.self, forKey: .to)
        let rate = try container.decode(String.self, forKey: .rate)
        self.init(from: from, to: to, rate: rate)
    }
}
