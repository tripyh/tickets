//
//  NibLoadableViewProtocol.swift
//  Tickets
//
//  Created by andrey rulev on 16.07.2022.
//

import UIKit

protocol NibLoadableViewProtocol: AnyObject {
    static var nibName: String { get }
}

extension NibLoadableViewProtocol where Self: UITableViewCell {
    static var nibName: String {
        return String(describing: self)
    }
}
