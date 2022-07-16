//
//  MainCell.swift
//  Tickets
//
//  Created by andrey rulev on 16.07.2022.
//

import UIKit

class MainCell: BaseTableViewCell {
    
    // MARK: - Private properties
    
    @IBOutlet private var skuLabel: UILabel!
    
    // MARK: - PrepareForReuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        skuLabel.text = nil
    }
    
    // MARK: - Configure
    
    func configure(_ cellMode: MainCellModel?) {
        skuLabel.text = cellMode?.sku
    }
}
