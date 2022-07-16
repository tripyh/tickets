//
//  MainViewModel.swift
//  Tickets
//
//  Created by andrey rulev on 16.07.2022.
//

import ReactiveCocoa
import ReactiveSwift

struct MainCellModel {
    let sku: String
}

struct DetailModel {
    let transactions: [TransactionModel]
    let rates: [RateModel]
}

class MainViewModel {
    
    // MARK: - Public properties
    
    let reload: Signal<(), Never>
    let showError: Signal<String, Never>
    var loading: Property<Bool> { return Property(_loading) }
    
    // MARK: - Private properties
    
    private let reloadObserver: Signal<(), Never>.Observer
    private let showErrorObserver: Signal<String, Never>.Observer
    private let _loading: MutableProperty<Bool> = MutableProperty(false)
    
    private var cellModels = [MainCellModel]()
    private var rates = [RateModel]()
    private var transactions = [TransactionModel]()
    
    // MARK: - Lifecycle
    
    init() {
        (reload, reloadObserver) = Signal.pipe()
        (showError, showErrorObserver) = Signal.pipe()
    }
}

// MARK: - DataSource

extension MainViewModel {
    var numberOfRows: Int {
        return cellModels.count
    }
    
    func cellModel(at index: Int) -> MainCellModel? {
        guard 0..<cellModels.count ~= index else {
            return nil
        }
        
        return cellModels[index]
    }
    
    func detailModel(at index: Int) -> DetailModel {
        let cellModel = cellModel(at: index)
        var tempTransactions = [TransactionModel]()
        
        for transaction in transactions {
            if cellModel?.sku == transaction.sku {
                tempTransactions.append(transaction)
            }
        }
        
        let detailModel = DetailModel(transactions: tempTransactions, rates: rates)
        return detailModel
    }
}

extension MainViewModel {
    func loadData() {
        fetchRates()
    }
}

// MARK: - Private API

private extension MainViewModel {
    func fetchRates() {
        _loading.value = true
        
        TicketManager.rates { [weak self] rateArray, errorMessage in
            guard let strongSelf = self else {
                return
            }
            
            if let errorActual = errorMessage {
                strongSelf._loading.value = false
                strongSelf.showErrorObserver.send(value: errorActual)
            } else if let rateArrayActual = rateArray {
                strongSelf.rates = rateArrayActual
                strongSelf.fetchTransactions()
            }
        }
    }
    
    func fetchTransactions() {
        TicketManager.transactions { [weak self] transactionArray, errorMessage in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf._loading.value = false
            
            if let errorActual = errorMessage {
                strongSelf.showErrorObserver.send(value: errorActual)
            } else if let transactionArrayActual = transactionArray {
                strongSelf.transactions = transactionArrayActual
                strongSelf.fillCellModels()
            }
        }
    }
}

// MARK: - Private

private extension MainViewModel {
    func fillCellModels() {
        var dict = [String : String]()
        
        var tempCellModels = [MainCellModel]()
        
        for transaction in transactions {
            if dict[transaction.sku] == nil {
                dict[transaction.sku] = transaction.sku
                let cellModel =  MainCellModel(sku: transaction.sku)
                tempCellModels.append(cellModel)
            }
        }
        
        cellModels = tempCellModels
        reloadObserver.send(value: ())
    }
}
