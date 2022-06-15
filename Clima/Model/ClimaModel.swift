import Foundation

struct ClimaModel{
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let description: String
    let cloud: Int
    let date: Date
    let sunRise: Date
    let sunDown: Date
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    var conditionName: String{
        switch conditionId {
        case 200...232:
            return clima.Cloud.cloudSunBolt
        case  300...321:
            return clima.Cloud.cloudRainFill
        case 500...504:
            return clima.Cloud.cloudSunRain
        case 514:
            return clima.Snow.snowFlakeCircle
        case 520...532:
            return clima.Cloud.cloudSunRain
        case 600...622:
            return clima.Snow.snowFlake
        case 701...781:
            return clima.Cloud.cloudFogFill
        case 800:
            return clima.Sun.sunMaxFill
        case 801:
            return clima.Cloud.cloudSunFill
        case 802:
            return clima.Cloud.cloud
        case 803...804:
            return clima.Cloud.cloudFill
        default:
            return clima.Sun.sunMax
            
        }
    }
    
}
