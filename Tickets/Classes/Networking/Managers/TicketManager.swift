//
//  TicketManager.swift
//  Tickets
//
//  Created by andrey rulev on 16.07.2022.
//

import Foundation
import Moya

class TicketManager {
    private static let provider = MoyaProvider<TicketService>()
    
    class func rates(_ completionHendler: @escaping([RateModel]?, String?) -> Void) {
        provider.request(.rates) { result in
            switch result {
            case .success(let success):
                do {
                    let rateArray = try JSONDecoder().decode([RateModel].self, from: success.data)
                    completionHendler(rateArray, nil)
                } catch let error {
                    completionHendler(nil, error.localizedDescription)
                }
            case .failure(let error):
                completionHendler(nil, error.localizedDescription)
            }
        }
    }
    
    class func transactions(_ completionHendler: @escaping([TransactionModel]?, String?) -> Void) {
        provider.request(.transactions) { result in
            switch result {
            case .success(let success):
                do {
                    let transactionArray = try JSONDecoder().decode([TransactionModel].self, from: success.data)
                    completionHendler(transactionArray, nil)
                } catch let error {
                    completionHendler(nil, error.localizedDescription)
                }
            case .failure(let error):
                completionHendler(nil, error.localizedDescription)
            }
        }
    }
}
