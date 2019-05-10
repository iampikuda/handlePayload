//
//  ResultModel.swift
//  HandlePayload
//
//  Created by Oluwadamisi Pikuda on 09/05/2019.
//  Copyright © 2019 Oluwadamisi Pikuda. All rights reserved.
//

import Foundation

struct ResultModel: Decodable {
    let result: Bool
    let payload: Payload?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case result, payload, message
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            if let resultBool = try? container.decode(Bool.self, forKey: .result) {
                result = resultBool
            } else if let resultString = try? container.decode(String.self, forKey: .result).bool {
                result = resultString
            } else if let resultNumber = try? container.decode(Int.self, forKey: .result).bool {
                result = resultNumber
            } else {
                throw ParsingError("Invalid Result. Please check backend implementation")
            }

            if let decodedPayload = try container.decodeIfPresent(Payload.self, forKey: .payload) {
                switch decodedPayload {
                case .object, .array:
                    payload = decodedPayload
                default:
                    payload = nil
                }
            } else {
                payload = nil
            }

            message = try container.decodeIfPresent(String.self, forKey: .message)
        }
    }
}

extension String {
    var bool: Bool? {
        switch self.lowercased() {
        case "true", "t", "truth": return true
        case "false", "f": return false
        default: return nil
        }
    }
}

extension Int {
    var bool: Bool? {
        switch self {
        case 1: return true
        case 0: return false
        default: return nil
        }
    }
}
