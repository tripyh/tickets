//
//  DetailVC.swift
//  Tickets
//
//  Created by andrey rulev on 16.07.2022.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class DetailVC: UIViewController {
    
    // MARK: - Private properties
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var totalLabel: UILabel!
    
    private let viewModel: DetailViewModel
    private let (lifetime, token) = Lifetime.make()
    
    private var showTotal: BindingTarget<String> {
        return BindingTarget(lifetime: lifetime, action: { [weak self] totalAmount in
            self?.totalLabel.text = totalAmount
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
        viewModel.calculateTotal()
    }
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure

private extension DetailVC {
    func configure() {
        navigationItem.title = viewModel.title
        totalLabel.text = "0"
        tableView.register(DetailCell.self)
    }
}

// MARK: - BindingViewModel

private extension DetailVC {
    func bindingViewModel() {
        showTotal <~ viewModel.showTotal
    }
}

// MARK: - UITableViewDataSource

extension DetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailCell = tableView.dequeueReusableCell(for: indexPath)
        let cellModel = viewModel.cellModel(at: indexPath.row)
        cell.configure(cellModel)
        return cell
    }
}

