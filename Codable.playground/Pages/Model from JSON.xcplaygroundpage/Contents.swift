/*:
 [Table of Contents](Table%20of%20Contents) • [Previous page](@previous)
 
 # Building a Model from JSON
 */

// A portion of the JSON response from the Dark Sky API. https://darksky.net/dev/docs#forecast-request

// Also, super handy, simply begin/end your multiline string with 3 double quotes to allow
// for newlines. String literals like this still support interpolation, but characters like
// individual double quotes do not need to be escaped.

import Foundation

let json = """
{
    "latitude": 42.3601,
    "longitude": -71.0589,
    "timezone": "America/New_York",
    "currently":
    {
        "time": 1509993277,
        "summary": "Drizzle",
        "precipIntensity": 0.0089,
        "precipIntensityError": 0.0046,
        "precipProbability": 0.9,
        "precipType": "rain",
        "temperature": 66.1,
        "apparentTemperature": 66.31,
        "dewPoint": 60.77,
        "humidity": 0.83,
        "windSpeed": 5.59,
        "windGust": 12.03,
        "windBearing": 246,
        "cloudCover": 0.7,
        "visibility": 9.84
    }
}
"""

struct Forecast: Codable {
    let latitude: Double
    let longitude: Double
    let timezone: String
    let currently: Currently
    
    struct Currently: Codable {
        let time: Date
        let summary: String
        let precipIntensity: Double
        let precipProbability: Double
        let precipType: String
        let temperature: Double
        let apparentTemperature: Double
        let humidity: Double
        let windSpeed: Double
        let visibility: Double
    }
}

let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .secondsSince1970
let jsonData = json.data(using: .utf8)!
let decodedForecast = try decoder.decode(Forecast.self, from: jsonData)


//: [Table of Contents](Table%20of%20Contents) • [Previous page](@previous)
