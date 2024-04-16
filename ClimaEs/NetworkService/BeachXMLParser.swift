//
//  XMLManager.swift
//  ClimaEs
//
//  Created by Sergei Kornilov on 09/04/2024.
//

import Foundation
import Alamofire

class WeatherPredictionParser: NSObject, XMLParserDelegate {
    private var predictions: [DayPrediction] = []
    
    private var tempDate: String?
    
    private var tempDescripcion1: String?
    private var tempDescripcion2: String?
    private var tempF1: Int?
    private var tempF2: Int?
    
    private var tempMaxTemp: Int?
    private var tempSTermicaValor: Int?
    private var tempSTermicaDescripcion: String?
    private var tempTAguaValor: Int?
    private var tempUVIndex: Int?
    
    var weatherPrediction: WeatherPrediction?
    
    private var elementValue: String?
    
    override init() {
        super.init()
    }
    
    func parseWeatherPrediction(data: Data) -> WeatherPrediction? {
        let parser = XMLParser(data: data)
        parser.delegate = self
        if parser.parse() {
            return WeatherPrediction(prediccion: Prediccion(day: predictions))
        }
        return nil
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        elementValue = ""
        switch elementName {
        case "estado_cielo", "viento", "oleaje":
            tempF1 = Int(attributeDict["f1"] ?? "0")
            tempF2 = Int(attributeDict["f2"] ?? "0")
            tempDescripcion1 = attributeDict["descripcion1"] ?? ""
            tempDescripcion2 = attributeDict["descripcion2"] ?? ""
            //print("## \(elementName) = \(String(describing: tempF1)) (\(String(describing: tempDescripcion1))),\(String(describing: tempF2)) (\(String(describing: tempDescripcion2)))")
        case "t_maxima":
            tempMaxTemp = Int(attributeDict["valor1"] ?? "0")
            //print("## \(elementName) = \(String(describing: tempMaxTemp))")
        case "s_termica":
            tempSTermicaValor = Int(attributeDict["valor1"] ?? "0")
            tempSTermicaDescripcion = attributeDict["descripcion1"] ?? ""
            //print("## \(elementName) = \(String(describing: tempSTermicaValor)) (\(String(describing: tempSTermicaDescripcion)))")
        case "t_agua":
            let valor = attributeDict["valor1"]
            tempTAguaValor = valor?.lowercased() == "nd" ? nil : Int(valor ?? "0")
            //print("## \(elementName) = \(String(describing: tempTAguaValor))")
        case "uv_max":
            tempUVIndex = Int(attributeDict["valor1"] ?? "0")
            //print("## \(elementName) = \(String(describing: tempUVIndex))")
        case "dia":
            if let dateString = attributeDict["fecha"] {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyyMMdd"
                if let date = dateFormatter.date(from: dateString) {
                    dateFormatter.dateFormat = "ddMMyyyy"
                    tempDate = dateFormatter.string(from: date)
                }
            }
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        elementValue? += string.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
        case "dia":
            if let dateString = tempDate, let dateInt = Int(dateString) {
                let dayPrediction = DayPrediction(
                    date: dateInt,
                    skyCondition: WeatherCondition(f1: tempF1 ?? 0, descripcion1: tempDescripcion1 ?? "", f2: tempF2 ?? 0, descripcion2: tempDescripcion2 ?? ""),
                    wind: WindCondition(f1: tempF1 ?? 0, descripcion1: tempDescripcion1 ?? "", f2: tempF2 ?? 0, descripcion2: tempDescripcion2 ?? ""),
                    wave: WaveCondition(f1: tempF1 ?? 0, descripcion1: tempDescripcion1 ?? "", f2: tempF2 ?? 0, descripcion2: tempDescripcion2 ?? ""),
                    maximumTemperature: MaxTemperature(valor1: tempMaxTemp ?? 0),
                    thermalSensation: ThermalSensation(valor1: tempSTermicaValor ?? 0, descripcion1: tempSTermicaDescripcion ?? ""),
                    waterTemperature: WaterTemperature(valor1: tempTAguaValor ?? 0),
                    maximumUV: UVIndex(valor1: tempUVIndex ?? 0)
                )
                predictions.append(dayPrediction)
                    //print("\nДобавлен DayPrediction: \(dayPrediction)")
                resetTempVariables()
            }
        case "prediccion":
            weatherPrediction = WeatherPrediction(prediccion: Prediccion(day: predictions))
            //print("\n weatherPrediction = \(String(describing: weatherPrediction))")
        default:
            break
        }
        elementValue = nil
    }
    
    private func createDayPrediction(dateInt: Int) -> DayPrediction {
        return DayPrediction(date: dateInt, skyCondition: WeatherCondition(f1: tempF1 ?? 0, descripcion1: tempDescripcion1 ?? "", f2: tempF2 ?? 0, descripcion2: tempDescripcion2 ?? ""), wind: WindCondition(f1: tempF1 ?? 0, descripcion1: tempDescripcion1 ?? "", f2: tempF2 ?? 0, descripcion2: tempDescripcion2 ?? ""), wave: WaveCondition(f1: tempF1 ?? 0, descripcion1: tempDescripcion1 ?? "", f2: tempF2 ?? 0, descripcion2: tempDescripcion2 ?? ""), maximumTemperature: MaxTemperature(valor1: tempMaxTemp ?? 0), thermalSensation: ThermalSensation(valor1: tempSTermicaValor ?? 0, descripcion1: ""), waterTemperature: WaterTemperature(valor1: tempTAguaValor ?? 0), maximumUV: UVIndex(valor1: tempUVIndex ?? 0))
    }
    
    
    private func resetTempVariables() {
        tempDate = nil
        tempMaxTemp = nil
        tempUVIndex = nil
        tempF1 = nil
        tempF2 = nil
        tempDescripcion1 = nil
        tempDescripcion2 = nil
        tempSTermicaValor = nil
        tempTAguaValor = nil
    }
}
