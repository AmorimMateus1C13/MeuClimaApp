import UIKit
import CoreLocation

class ClimaViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var climaImage: UIImageView!
    
    @IBOutlet weak var textUserSearch: UITextField!
    
    @IBOutlet weak var localLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!

    var climaManager = ClimaManager()
    let locationManager = CLLocationManager()
    var model: ClimaModel?
    
    func setupModel(model: ClimaModel) {
        self.model = model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        climaManager.delegate = self
        textUserSearch.delegate = self
        tableview.dataSource = self
        tableview.delegate = self
        tableview.backgroundColor = .clear
        tableview.register(UINib(nibName: TVCell.cellNibname, bundle: nil), forCellReuseIdentifier: TVCell.cellIdentifier)
    }
    
}

extension ClimaViewController: ClimaManagerDelegate {
    func didUpdateClima(_ requesitorDeAPI: ClimaManager, condicoes: ClimaModel) {
        DispatchQueue.main.async {
            self.climaImage.image = UIImage(systemName: condicoes.conditionName)
            self.localLabel.text = condicoes.cityName
            self.tempLabel.text = "\(condicoes.temperatureString)°"
            self.descriptionLabel.text = condicoes.description.capitalized
            self.model = condicoes
            self.tableview.reloadData()
        }
    }
    
    
    func didFailWithError(error: Error) {
        print("Problemas com o DidFailWithError. Erro: \(error)")
    }
    
}

extension ClimaViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            climaManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Erro de domínio ao usar o Simulador do Xcode sem ter um local definido no simulador\(error)")
    }
    // Funciona como Localizar sua posicao atual no mapa
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.locationManager.requestLocation()
        }
    }
}

extension ClimaViewController: UITextFieldDelegate{
    
    @IBAction func searchButton(_ sender: UIButton) {
        textUserSearch.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textUserSearch.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textUserSearch.text != ""{
            return true
        }else {
            textUserSearch.placeholder = "type something"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = textUserSearch.text{
            climaManager.fetchWeather(city: city)
        }
        textUserSearch.text = ""
    }
}

extension ClimaViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: TVCell.cellIdentifier, for: indexPath) as! MessageCell
        guard let date = model?.date else { return cell }
        guard let temp_min = model?.temp_min else { return cell }
        guard let temp_max = model?.temp_max else { return cell }
        guard let humidity = model?.humidity else { return cell }
        guard let sunrise = model?.sunRise else { return cell }
        guard let sunset = model?.sunDown else { return cell }
        
        cell.dateLabel.text = "\(date.formatted(date: .numeric, time: .omitted).dropLast(5))"
        cell.dayLabel.text = "\(date.formatted(date: .omitted, time: .shortened))"
        cell.tempMInLabel.text = String(format: "%.1f", temp_min) + "°"
        cell.tempMaxLabel.text = String(format: "%.1f", temp_max) + "°"
        cell.humidity.text = String(humidity) + "%"
        cell.sunRaiseLabel.text = sunrise.formatted(date: .omitted, time: .shortened)
        cell.sunSetLabel.text = sunset.formatted(date: .omitted, time: .shortened)
        cell.humidityImage.image = UIImage(systemName: clima.Others.humidityFill)
        
        if temp_min < 5.0 {
            cell.minImage.image = UIImage(systemName: clima.Others.thermometerSnowFlake)
        }else{
            cell.minImage.image = UIImage(systemName: clima.Others.thermometer)
        }
        
        if temp_max > 25.0 {
            cell.maxImage.image = UIImage(systemName: clima.Others.thermometerSunFill)
        }else {
            cell.maxImage.image = UIImage(systemName: clima.Others.thermometer)
        }
        
        cell.backgroundColor = .clear
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

}
