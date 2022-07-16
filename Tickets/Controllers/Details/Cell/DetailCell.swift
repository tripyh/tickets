//
//  DetailCell.swift
//  Tickets
//
//  Created by andrey rulev on 16.07.2022.
//

import UIKit

class DetailCell: BaseTableViewCell {
    
    // MARK: - Private properties
    
    @IBOutlet private var amountLabel: UILabel!
    @IBOutlet private var currencyLabel: UILabel!

    // MARK: - PrepareForReuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        amountLabel.text = nil
        currencyLabel.text = nil
    }
    
    // MARK: - Configure
    
    func configure(_ cellModel: DetailCellModel?) {
        amountLabel.text = cellModel?.amount
        currencyLabel.text = cellModel?.currency
    }
}
