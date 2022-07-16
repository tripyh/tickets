//
//  DetailViewModel.swift
//  Tickets
//
//  Created by andrey rulev on 16.07.2022.
//

import Foundation

struct DetailCellModel {
    let amount: String
    let currency: String
}

class DetailViewModel {
    
    // MARK: - Private properties
    
    private var cellModels = [DetailCellModel]()
    private let transactions: [TransactionModel]
    private let rates: [RateModel]
    
    // MARK: - Lifecycle
    
    init(transactions: [TransactionModel], rates: [RateModel]) {
        self.transactions = transactions
        self.rates = rates
        fillCellModels()
    }
}

// MARK: - DataSource

extension DetailViewModel {
    var numberOfRows: Int {
        return cellModels.count
    }
    
    func cellModel(at index: Int) -> DetailCellModel? {
        guard 0..<cellModels.count ~= index else {
            return nil
        }
        
        return cellModels[index]
    }
    
    var totalEur: String {
        return "0"
    }
}

// MARK: - Private

private extension DetailViewModel {
    func fillCellModels() {
        var tempCellModels = [DetailCellModel]()
        
        for transaction in transactions {
            let cellModel = DetailCellModel(amount: transaction.amount,
                                            currency: transaction.currency)
            tempCellModels.append(cellModel)
        }
        
        cellModels = tempCellModels
    }
    
    func calculateTotal() {
        
    }
}
