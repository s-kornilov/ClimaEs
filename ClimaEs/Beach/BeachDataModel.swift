//
//  BeachDataModel.swift
//  ClimaEs
//
//  Created by Sergei Kornilov on 29/03/2024.
//

import Foundation

struct WeatherPrediction: Decodable {
    let prediccion: Prediccion
}

struct Prediccion: Decodable {
    let day: [DayPrediction]
    
    enum CodingKeys: String, CodingKey {
        case day = "dia"
    }
    
}

struct DayPrediction: Decodable {
    let date: Int
    let skyCondition: WeatherCondition
    let wind: WindCondition
    let wave: WaveCondition
    let maximumTemperature: MaxTemperature
    let thermalSensation: ThermalSensation
    let waterTemperature: WaterTemperature
    let maximumUV: UVIndex
    
    enum CodingKeys: String, CodingKey {
        case date = "fecha"
        case skyCondition = "estadoCielo"
        case wind = "viento"
        case wave = "oleaje"
        case maximumTemperature = "tMaxima"
        case thermalSensation = "sTermica"
        case waterTemperature = "tAgua"
        case maximumUV = "uvMax"
    }
}

struct WeatherCondition: Decodable {
    let f1: Int
    let descripcion1: String
    let f2: Int
    let descripcion2: String
}

struct WindCondition: Decodable {
    let f1: Int
    let descripcion1: String
    let f2: Int
    let descripcion2: String
}

struct WaveCondition: Decodable {
    let f1: Int
    let descripcion1: String
    let f2: Int
    let descripcion2: String
}

struct MaxTemperature: Decodable {
    let valor1: Int
}

struct ThermalSensation: Decodable {
    let valor1: Int
    let descripcion1: String
}

struct WaterTemperature: Decodable {
    let valor1: Int
}

struct UVIndex: Decodable {
    let valor1: Int
}
