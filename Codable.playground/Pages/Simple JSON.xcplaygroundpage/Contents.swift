/*:
 [Table of Contents](Table%20of%20Contents) • [Previous page](@previous) • [Next page](@next)
 
 # Simple JSON Encoder/Decoder
 
 With Swift 4, marshaling data into and out of JSON format is much simpler. Let's imagine a model that we'll use to categorize a list of movies that are coming out this summer. The `struct` below is a simple model that provides properties for a movie's title, genre, and rating.
 
 Any custom type can be easily made archivable into JSON or other formats by having it conform to the `Codable` protocol.
 `Equatable` is a protocol that allows custom types to be compared with one another to determine equivalence. By adding the method to compare two objects of the same type, we can customize what constitutes equality for the `Movie` struct.
*/

struct Movie: Codable, Equatable {
    enum Genre: String, Codable {
        case action, drama, comedy, horror, documentary
    }
    
    enum Rating: String, Codable {
        case g, pg, pg13, r, nc17
    }
    
    var genre: Genre
    var rating: Rating
    var title: String
    
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.title == rhs.title && lhs.genre == rhs.genre && lhs.rating == rhs.rating
    }
}

let movies = [Movie(genre: .action, rating: .pg13, title: "Avengers: Infinity War"),
              Movie(genre: .action, rating: .r, title: "The Untitled Deadpool Sequel")]

//: ### Encoding

import Foundation

var encoder = JSONEncoder()
encoder.outputFormatting = [.prettyPrinted]

let jsonData = try encoder.encode(movies)
String(data: jsonData, encoding: .utf8)

//: ### Decoding

let decoder = JSONDecoder()
let decodedMovies = try decoder.decode([Movie].self, from: jsonData)
type(of: decodedMovies)
assert(decodedMovies == movies)

//: [Table of Contents](Table%20of%20Contents) • [Previous page](@previous) • [Next page](@next)
