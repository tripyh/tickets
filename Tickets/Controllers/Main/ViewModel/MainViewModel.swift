//
//  MainViewModel.swift
//  Tickets
//
//  Created by andrey rulev on 16.07.2022.
//

import Foundation


class MainViewModel {
    
}

extension MainViewModel {
    func loadData() {
        
    }
}

// MARK: - Private API

private extension MainViewModel {
    func fetchRates() {
        TicketManager.rates { rateArray, errorMessage in
            
        }
    }
    
    func fetchTransactions() {
        TicketManager.transactions { transactionArray, errorMessage in
            
        }
    }
}
