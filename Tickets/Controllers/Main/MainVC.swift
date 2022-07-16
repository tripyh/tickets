//
//  MainVC.swift
//  Tickets
//
//  Created by andrey rulev on 16.07.2022.
//

import UIKit

class MainVC: UIViewController {
    
    // MARK: - Private properties
    
    private let viewModel: MainViewModel
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadData()
    }
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
