//
//  MainVC.swift
//  Tickets
//
//  Created by andrey rulev on 16.07.2022.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import SVProgressHUD

class MainVC: UIViewController {
    
    // MARK: - Private properties
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var loaderView: UIActivityIndicatorView!
    
    private let viewModel: MainViewModel
    private let (lifetime, token) = Lifetime.make()
    
    private var showError: BindingTarget<String> {
        return BindingTarget(lifetime: lifetime, action: { [weak self] message in
            self?.showError(message)
        })
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bindingViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if viewModel.numberOfRows == 0 {
            viewModel.loadData()
        }
    }
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure

private extension MainVC {
    func configure() {
        navigationItem.title = "Transactions"
        tableView.register(MainCell.self)
    }
}

// MARK: - BindingViewModel

private extension MainVC {
    func bindingViewModel() {
        tableView.reactive.reloadData <~ viewModel.reload
        loaderView.reactive.isAnimating <~ viewModel.loading
        showError <~ viewModel.showError
    }
}

// MARK: - UITableViewDataSource

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MainCell = tableView.dequeueReusableCell(for: indexPath)
        let cellModel = viewModel.cellModel(at: indexPath.row)
        cell.configure(cellModel)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailModel = viewModel.detailModel(at: indexPath.row)
        pushToDetails(detailModel)
    }
}

// MARK: - Navigation

private extension MainVC {
    func pushToDetails(_ detailModel: DetailModel) {
        let detailViewModel = DetailViewModel(transactions: detailModel.transactions,
                                              rates: detailModel.rates)
        let detailVC = DetailVC(viewModel: detailViewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - Private

private extension MainVC {
    func showError(_ error: String) {
        SVProgressHUD.show(withStatus: error)
        SVProgressHUD.dismiss(withDelay: 2)
    }
}
