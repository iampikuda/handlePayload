//
//  HandlePayloadTests.swift
//  HandlePayloadTests
//
//  Created by Oluwadamisi Pikuda on 08/05/2019.
//  Copyright © 2019 Oluwadamisi Pikuda. All rights reserved.
//

import XCTest
@testable import HandlePayload

class HandlePayloadTests: XCTestCase {

    func dataFrom(fixture: String) -> Data? {
        return fixture.data(using: .utf8)
    }

    func testFailingData() {
        XCTAssertThrowsError(try PayloadParser().payload(from: nil)) { error in
            XCTAssertEqual((error as! ParsingError).localizedDescription, "Error:- No data from server")
        }

        XCTAssertThrowsError(try PayloadParser().payload(from: self.dataFrom(fixture: Fixture.failure.emptyData))) { error in
            XCTAssertEqual((error as! ParsingError).localizedDescription, "Error:- Invalid data format")
        }

        XCTAssertThrowsError(try PayloadParser().payload(from: self.dataFrom(fixture: Fixture.failure.noData))) { error in
            XCTAssertEqual((error as! ParsingError).localizedDescription, "Error:- Invalid Result. Please check backend implementation")
        }

        XCTAssertThrowsError(try PayloadParser().payload(from: self.dataFrom(fixture: Fixture.failure.invalidResult))) { error in
            XCTAssertEqual((error as! ParsingError).localizedDescription, "Error:- Invalid Result. Please check backend implementation")
        }

        XCTAssertThrowsError(try PayloadParser().payload(from: self.dataFrom(fixture: Fixture.failure.noResult))) { error in
            XCTAssertEqual((error as! ParsingError).localizedDescription, "Error:- Invalid Result. Please check backend implementation")
        }

        XCTAssertThrowsError(try PayloadParser().payload(from: self.dataFrom(fixture: Fixture.failure.falseResult))) { error in
            XCTAssertEqual((error as! ParsingError).localizedDescription, "Error:- False!!!")
        }

        XCTAssertThrowsError(try PayloadParser().payload(from: self.dataFrom(fixture: Fixture.failure.missingMessage))) { error in
            XCTAssertEqual((error as! ParsingError).localizedDescription, "Error:- Missing message. Please check backend implementation.")
        }

        XCTAssertThrowsError(try PayloadParser().payload(from: self.dataFrom(fixture: Fixture.failure.invalidMessage))) { error in
            XCTAssertEqual((error as! ParsingError).localizedDescription, "Error:- Invalid data format")
        }

        XCTAssertThrowsError(try PayloadParser().payload(from: self.dataFrom(fixture: Fixture.failure.invalidPayload))) { error in
            XCTAssertEqual((error as! ParsingError).localizedDescription, "Error:- Invalid data format")
        }

        XCTAssertThrowsError(try PayloadParser().payload(from: self.dataFrom(fixture: Fixture.failure.noPayload))) { error in
            XCTAssertEqual((error as! ParsingError).localizedDescription, "Error:- Invalid data format")
        }
    }

    func testSucessfullData(){
        guard let payloadOne = try? PayloadParser().payload(
            from: self.dataFrom(fixture: Fixture.success.arrayPayload)) as? Payload,
            let payloadTwo = try? PayloadParser().payload(
                from: self.dataFrom(fixture: Fixture.success.objectPayload)) as? Payload,
            let _ = try? PayloadParser().payload(
                from: self.dataFrom(fixture: Fixture.success.numberResult)) as? Payload,
            let _ = try? PayloadParser().payload(
                from: self.dataFrom(fixture: Fixture.success.stringResult)) as? Payload else {
                    XCTFail()
                    return
        }
        var payloadArray = [Int]()
        switch payloadOne {
        case .array(let value):
            value.forEach {
                switch $0 {
                case .int(let numb):
                    payloadArray.append(numb)
                default: XCTFail()
                }
            }
            XCTAssertEqual(payloadArray.sorted(), [1,2,3,4,5])
        default: XCTFail()
        }

        payloadArray = []
        switch payloadTwo {
        case .object(let value):
            XCTAssertEqual(value.keys.count, 2)
            guard let one = value["one"], let two = value["two"] else {
                XCTFail()
                return
            }

            switch one {
            case .int(let numb):
                payloadArray.append(numb)
            default: XCTFail()
            }

            switch two {
            case .int(let numb):
                payloadArray.append(numb)
            default: XCTFail()
            }
            XCTAssertEqual(payloadArray.sorted(), [1,2])
        default: XCTFail()
        }
    }
}
