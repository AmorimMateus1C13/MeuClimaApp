import Foundation
import CoreLocation

struct ClimaData: Codable {
    let coord: Coord
    let weather : [Weather]
    let name: String
    let sys: Sys
    let base: String
    let main: Main
    let wind: Wind
    let clouds: Cloud
    let dt: Date
    
}
struct Coord: Codable {
    let lon: CLLocationDegrees
    let lat: CLLocationDegrees
}
struct Weather: Codable {
    let id: Int
    let description: String
    let main: String
    
}
struct Main: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
    
}
struct Wind : Codable {
    let speed: Double
}
struct Cloud: Codable {
    let all: Int
}

struct Sys: Codable {
    let country: String
    let sunrise: Date
    let sunset: Date
}
