# handlePayload

```
class PayloadParser: PayloadParserProtocol {
    func payload(from data: Data?) throws -> Any? {
        do {
            guard let data = data else { throw ParsingError("No data from server") }

            let decodedData = try JSONDecoder().decode(ResultModel.self, from: data)
            if !decodedData.result, let message = decodedData.message {
                throw ParsingError(message)
            } else if !decodedData.result {
                throw ParsingError("Missing message. Please check backend implementation.")
            }

            if let payload = decodedData.payload {
                return payload
            } else {
                throw ParsingError("Data has no usuable payload")
            }
        } catch let error {
            if error is DecodingError {
                throw ParsingError("Invalid data format")
            }
            throw error
        }
    }
}
```

This is just a simple function for decoding data from a server.


### Tests

Run `CMD + U` for tests.
