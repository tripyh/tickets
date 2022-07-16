//
//  TicketService.swift
//  Tickets
//
//  Created by andrey rulev on 16.07.2022.
//

import Moya

enum TicketService: NetworkTarget {
    case rates
    case transactions
    
    var path: String {
        switch self {
        case .rates:
            return "rates.json"
        case .transactions:
            return "transactions.json"
        }
    }
    
    var method: Method {
        return .get
    }
}
