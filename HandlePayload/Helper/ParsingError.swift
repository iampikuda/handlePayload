//
//  ParsingError.swift
//  HandlePayload
//
//  Created by Oluwadamisi Pikuda on 09/05/2019.
//  Copyright © 2019 Oluwadamisi Pikuda. All rights reserved.
//

import Foundation

struct ParsingError: Error {
    var localizedDescription: String

    public init(_ description: String) {
        localizedDescription =  "Error:- \(description)"
    }
}
