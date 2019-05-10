//
//  Fixture.swift
//  HandlePayloadTests
//
//  Created by Oluwadamisi Pikuda on 09/05/2019.
//  Copyright © 2019 Oluwadamisi Pikuda. All rights reserved.
//

import Foundation

enum Fixture {
    enum success {
        static let arrayPayload =
        """
        {
        "result": "t",
        "payload": [1,2,3,4,5]
        }
        """
        static let objectPayload =
        """
        {
        "result": true,
        "payload": {"one": 1, "two": 2}
        }
        """
        static let numberResult =
        """
        {
        "result" : 1,
        "payload": {"one": 1, "two": 2}
        }
        """
        static let stringResult =
        """
        {
        "result" : "True",
        "payload": {"one": 1, "two": 2}
        }
        """
    }

    enum failure {
        static let emptyData = ""
        static let noData =
        """
        {}
        """
        static let invalidResult =
        """
        {
        "result" : 90,
        "message" : "Invalid result buddy"
        }
        """
        static let noResult =
        """
        {
        "message" : "No result given."
        }
        """
        static let falseResult =
        """
        {
        "result" : false,
        "message" : "False!!!"
        }
        """
        static let missingMessage =
        """
        {
        "result" : false
        }
        """
        static let invalidMessage =
        """
        {
        "result" : 0,
        "message" : 90
        }
        """
        static let invalidPayload =
        """
        {
        "result" : True,
        "payload": "payload"
        }
        """
        static let noPayload =
        """
        {
        "result" : t
        }
        """
    }
}
