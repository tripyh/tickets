//
//  DetailViewModel.swift
//  Tickets
//
//  Created by andrey rulev on 16.07.2022.
//

import ReactiveCocoa
import ReactiveSwift

struct DetailCellModel {
    let amount: String
    let currency: String
}

class DetailViewModel {
    
    // MARK: - Public properties
    
    let showTotal: Signal<String, Never>
    
    // MARK: - Private properties
    
    private let showTotalObserver: Signal<String, Never>.Observer
    
    private var cellModels = [DetailCellModel]()
    private let transactions: [TransactionModel]
    private let rates: [RateModel]
    
    // MARK: - Lifecycle
    
    init(transactions: [TransactionModel], rates: [RateModel]) {
        self.transactions = transactions
        self.rates = rates
        (showTotal, showTotalObserver) = Signal.pipe()
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
}

// MARK: - Public

extension DetailViewModel {
    func calculateTotal() {
        var price: NSDecimalNumber = 0.0
        
        for transaction in transactions {
            let currentPrice = NSDecimalNumber(string: transaction.amount)
            
            if transaction.currency == "EUR" {
                price = price.adding(currentPrice)
            } else {
                if let rate = rateFrom(transaction.currency) {
                    let ratePrice = currentPrice.multiplying(by: rate)
                    price = price.adding(ratePrice)
                }
            }
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency

        if let stringFormat = numberFormatter.string(for: price) {
            showTotalObserver.send(value: stringFormat)
        }
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
    
    func rateFrom(_ from: String) -> NSDecimalNumber? {
        for rate in rates {
            if rate.from == from {
                return NSDecimalNumber(string: rate.rate)
            }
        }
        
        return nil
    }
}
