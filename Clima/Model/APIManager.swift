import Foundation
import CoreLocation

protocol ClimaManagerDelegate {
    func didUpdateClima (_ requesitorDeAPI: ClimaManager, condicoes: ClimaModel)
    func didFailWithError (error : Error)
}
struct ClimaManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?"
    let apiKey = "&appid=6be4196a200227d2702148c5e6a27cc0"
    let units = "&units=metric"
    let lang = "&lang=pt_br"
    var delegate: ClimaManagerDelegate?
    
    
    func fetchWeather(city: String){
        let urlString = "\(weatherURL)\(apiKey)\(units)\(lang)&q=\(city)"
        performRequest(with: urlString)
        print(urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
       let urlString = "\(weatherURL)\(apiKey)\(units)\(lang)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
//        let url2 = "http://history.openweathermap.org/data/2.5/history/city?\(apiKey)\(units)\(lang)&lat=\(latitude)&lon=\(longitude)&type=hour&start=1369728000&end=1369789200"
//        print(url2)
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    print("Problemas com o PerformRequest. Erro: \(error!)")
                    return
                }
                if let safeData = data {
                    if let clima = self.parseJson(clima: safeData){
                        ClimaViewController().setupModel(model: clima)
                        self.delegate?.didUpdateClima(self, condicoes: clima)
                        
                    }
                }
                }
            task.resume()
            }
    }
    
    func parseJson(clima: Data) -> ClimaModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ClimaData.self, from: clima)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let descricao = decodedData.weather[0].description
            let cloud = decodedData.clouds.all
            
            let date = decodedData.dt
            let sunRise = decodedData.sys.sunrise
            let sunDown = decodedData.sys.sunset
            let min = decodedData.main.temp_min
            let max = decodedData.main.temp_max
            let hum = decodedData.main.humidity
            print(sunDown.formatted(date: .omitted, time: .shortened))
            let climaWether = ClimaModel(
                conditionId: id,
                cityName: name,
                temperature: temp,
                description: descricao,
                cloud: cloud,
                date: date,
                sunRise: sunRise,
                sunDown: sunDown,
                temp_min: min,
                temp_max: max,
                humidity: hum
            )
            return climaWether
            
        }catch {
            delegate?.didFailWithError(error: error)
            print("Erro de escrita na chamada do ParseJSON. Erro: \(error)")
            return nil
        }
    }
}
