//
//  NetworkManager.swift
//  ClimaEs
//
//  Created by Sergei Kornilov on 29/03/2024.
//

import Foundation
import Alamofire

struct AemetResponse: Decodable {
    let descripcion: String
    let estado: Int
    let datos: String
    let metadatos: String
}

class NetworkManager {
    private let baseUrl = "https://opendata.aemet.es/opendata/api/prediccion/especifica/playa/"
    let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJjcmVzaGV6QGdtYWlsLmNvbSIsImp0aSI6IjM1NzhlYzExLTI5NDEtNDg5Yy04ZmU3LWQ3YTM2MDQ5YjNlNiIsImlzcyI6IkFFTUVUIiwiaWF0IjoxNzA4OTU0OTA4LCJ1c2VySWQiOiIzNTc4ZWMxMS0yOTQxLTQ4OWMtOGZlNy1kN2EzNjA0OWIzZTYiLCJyb2xlIjoiIn0.DPVqG_zwM6nqqckevuHmPhP5BUaHnKleI2kaj4QehdA"
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func getWeatherData(forCityId cityId: String, completion: @escaping (Result<String, Error>) -> Void) {
        let url = baseUrl + cityId
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(apiKey)",
            "Accept": "application/json"
        ]
        
        AF.request(url, headers: headers).responseDecodable(of: AemetResponse.self) { response in
            if let statusCode = response.response?.statusCode {
                print("##Код: \(statusCode)")
            }
            
            switch response.result {
            case .success(let data):
                // Datos obtenidos correctamente
                completion(.success(data.datos))
            case .failure(let afError):
                // Error de consulta, conversión del tipo AFError a Error
                completion(.failure(afError as Error))
            }
        }
    }
    
    // Recuperar datos meteorológicos específicos de una URL
    func fetchWeatherData(from url: String, completion: @escaping (Result<[WeatherPrediction], Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            
            do {
                // Descodificación de isoLatin a utf8
                guard let stringData = String(data: data, encoding: .isoLatin1),
                      let dataUTF8 = stringData.data(using: .utf8) else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Encoding conversion error"])))
                    return
                }
                let weatherData = try JSONDecoder().decode([WeatherPrediction].self, from: dataUTF8)
                
                DispatchQueue.main.async {
                    completion(.success(weatherData))
                }
                
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
        
    }
    
    
    func loadWeatherDataFromXML(forBeachId beachId: String, completion: @escaping (Result<WeatherPrediction, Error>) -> Void) {
        let xmlURLString = "https://www.aemet.es/xml/playas/play_v2_\(beachId).xml"
        
        print(xmlURLString)
        
        guard let url = URL(string: xmlURLString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        // Carga de datos XML con Alamofire
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                let parser = XMLParser(data: data)
                let xmlParserDelegate = WeatherPredictionParser()
                parser.delegate = xmlParserDelegate
                
                if parser.parse() {
                     if let weatherPrediction = xmlParserDelegate.weatherPrediction {
                        completion(.success(weatherPrediction))
                    } else {
                        // Error de parseo XML
                        completion(.failure(URLError(.cannotParseResponse)))
                    }
                } else {
                    // Error de parseo XML
                    completion(.failure(URLError(.cannotParseResponse)))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}

