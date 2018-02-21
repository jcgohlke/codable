/*:
 [Table of Contents](Table%20of%20Contents) • [Previous page](@previous) • [Next page](@next)
 
 # JSON Decoder Using Custom Keys
 
 Sometimes, often even, the keys used in the JSON document received from an API don't follow camelCase property naming. With the use of the CodingKey enum convention below, you can specify how the snake_case keys map to your camelCase keys.
 
 In fact, in Swift 4.1, currently in beta, you can simplify this even more by using the `keyDecodingStrategy` and `keyEncodingStrategy` properties of the `JSONDecoder` and `JSONEncoder` classes to tell it how to map between these different naming conventions.
 
 Example in Swift 4.1: `decoder.keyDecodingStrategy = .convertFromSnakeCase`
 */

import Foundation

let json = """
[
    {
        "name": "iPhone 8",
        "screen_size": 4.7,
        "biometric_auth": "Touch ID"
    },
    {
        "name": "iPhone X",
        "screen_size": 5.8,
        "biometric_auth": "Face ID"
    }
]
"""

struct Phone: Codable {
    let name: String
    let screenSize: Double
    let biometricAuth: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case screenSize = "screen_size"
        case biometricAuth = "biometric_auth"
    }
}

let jsonData = Data(json.utf8)

let decoder = JSONDecoder()
let decodedPhones = try decoder.decode([Phone].self, from: jsonData)

//: [Next](@next)
