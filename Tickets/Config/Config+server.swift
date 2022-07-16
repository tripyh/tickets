//
//  Config+server.swift
//  Tickets
//
//  Created by andrey rulev on 16.07.2022.
//

import Foundation

struct Config {
    static let serverBaseURL: URL = {
        return URL(string: "https://quiet-stone-2094.herokuapp.com/")!
    }()
}
