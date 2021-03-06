//
//  ViewController.swift
//
//
//  Created by Alexandru Bardea on 06/12/2020.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var DescriptionState: UILabel!
    
         var weatherManager = WeatherManager()
           let locationMan = CLLocationManager()
           
           override func viewDidLoad() {
               super.viewDidLoad()
            
            //current date
            let date0 = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            let result = formatter.string(from: date0)

            currentDate.text = result
            
               locationMan.delegate = self
               locationMan.requestWhenInUseAuthorization()
               locationMan.requestLocation()
               
               weatherManager.delegate = self
               searchTextField.delegate = self
        
        
       //        func GPSLocationPressed(_ sender: UIButton) {
            
      //  locationMan.requestLocation()
        //}
            
            
        }

}
        
       
        



    //MARK: - UiTextFieldDelegate


    // key = ddad6763cc1ea30d42f9c82e33a6bf15


    extension WeatherViewController: UITextViewDelegate {
        
        @IBAction func searchPressed(_ sender: UIButton) {
            searchTextField.endEditing(true)
            print(searchTextField.text!)
        
        }
        

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            
            searchTextField.endEditing(true)
            print(searchTextField.text!)
            return true
            
        }
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            if textField.text != ""{
            return true
            }else {
                textField.placeholder = "Type something here"
            return false
            }
            
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            // we search the city and do the rest of operations
            if let city = searchTextField.text{
                
                weatherManager.fetchWeather(cityName: city)
            }
            
            
            searchTextField.text = " "
        }
        
        
    }

    //MARK: - WeatherManagerDelegate


    extension WeatherViewController: WeatherManagerDelegate {
        
        func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
            DispatchQueue.main.async {
                
              
                self.temperatureLabel.text = weather.temperatureString
                self.conditionImageView.image = UIImage(systemName: weather.conditionName)
                self.cityLabel.text = weather.cityName
                self.DescriptionState.text = weather.descriprion
               // self.currentDate.text = ("\(day)  \(month), \(year)")
            }
        }
        
        func didFailWithError(error: Error) {
            print(error)
        }
    }


    //MARK: - Location Manager Delegate

    // we don t need to activate once again that location request
    extension WeatherViewController: CLLocationManagerDelegate{
        
        
        @IBAction func GPSPressed(_ sender: UIButton) {
        locationMan.requestLocation()
        }
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           
            //    print("got location")

            if let location = locations.last{
                
                locationMan.stopUpdatingLocation()
                let lat = location.coordinate.latitude
                let lon = location.coordinate.longitude
               // print(lat)
               // print(lon)
                weatherManager.fetchWeather(latitude:lat, longitude: lon)
            }
              
              }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error)
        }
        
        
    }
