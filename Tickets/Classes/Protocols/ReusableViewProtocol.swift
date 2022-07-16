//
//  ReusableViewProtocol.swift
//  Tickets
//
//  Created by andrey rulev on 16.07.2022.
//

import UIKit

protocol ReusableViewProtocol: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReusableViewProtocol where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
