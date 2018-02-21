/*:
 [Table of Contents](Table%20of%20Contents) • [Previous page](@previous)
 
 # Building a Model from JSON
 
 A common task in app building is consuming a third party API. Accurately and efficiently modeling the returned data is important and until recently, was a fairly involved and annoying process in Swift. With version 4 introducing the `Codable` protocol, it's now a much easier task to get what is needed from an API response.\
 
 Also, super handy, simply begin/end your multiline string with 3 double quotes to allow for newlines. String literals like this still support interpolation, but characters like individual double quotes do not need to be escaped. Another great addition to Swift in version 4.
 
 The JSON below is a truncated version of the forecast request from the Dark Sky API. It contains many more keys for all kinds of interesting weather related datapoints, but it was shortened below for brevity.
 
 Check out more information about the [Dark Sky weather API](https://darksky.net/dev/docs#forecast-request) if you need to add weather data to your app.
 */

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

// By using this date decoding strategy, the UNIX time value returned by the API in the "time" field will automatically be converted to a Date object by the decoder. Other enum values include milliseconds since 1970, ISO 8601, and even a way to provide your own custom formatter.
decoder.dateDecodingStrategy = .secondsSince1970

// Since the decoder is expecting a Data object, and normally we'd receive the JSON as a Data object from a network request, we'll convert our String to a Data object first using UTF8 encoding.
let jsonData = json.data(using: .utf8)!

// Simply provide the Data object to be decoded along with the class the decoder should expect. In this case the JSON represents a Forecast model object.
let decodedForecast = try decoder.decode(Forecast.self, from: jsonData)
//: [Table of Contents](Table%20of%20Contents) • [Previous page](@previous)
