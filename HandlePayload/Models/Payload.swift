//
//  Payload.swift
//  HandlePayload
//
//  Created by Oluwadamisi Pikuda on 09/05/2019.
//  Copyright © 2019 Oluwadamisi Pikuda. All rights reserved.
//

import Foundation

public enum Payload: Decodable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case object([String: Payload])
    case array([Payload])

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode(Int.self) {
            self = .int(value)
        } else if let value = try? container.decode(Double.self) {
            self = .double(value)
        } else if let value = try? container.decode(Bool.self) {
            self = .bool(value)
        } else if let value = try? container.decode([String: Payload].self) {
            self = .object(value)
        } else if let value = try? container.decode([Payload].self) {
            self = .array(value)
        } else {
            throw ParsingError("Payload object is invalid")
        }
    }
}
