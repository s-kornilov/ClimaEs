//
//  CityData.swift
//  ClimaEs
//
//  Created by Sergei Kornilov on 11/04/2024.
//

import Foundation
struct City {
    let provinceID: String
    let cityID: String
    let cityName: String
    let latitude: Double
    let longitude: Double
}

let provincia: [String: String] = [
    "Málaga": "29",
]

let cities: [City] = [

    City(provinceID: "29", cityID: "29007", cityName: "Alhaurín de la Torre", latitude: 36.66275, longitude: -4.56275),
    City(provinceID: "29", cityID: "29025", cityName: "Benalmádena", latitude: 36.59452, longitude: -4.57228),
    City(provinceID: "29", cityID: "29042", cityName: "Coín", latitude: 36.66005, longitude: -4.75656),
    City(provinceID: "29", cityID: "29043", cityName: "Colmenar", latitude: 36.90537, longitude: -4.33681),
    City(provinceID: "29", cityID: "29051", cityName: "Estepona", latitude: 36.42681, longitude: -5.14685),
    City(provinceID: "29", cityID: "29052", cityName: "Faraján", latitude: 36.61622, longitude: -5.18822),
    City(provinceID: "29", cityID: "29054", cityName: "Fuengirola", latitude: 36.53884, longitude: -4.62340),
    City(provinceID: "29", cityID: "29055", cityName: "Fuente de Piedra", latitude: 37.13528, longitude: -4.72989),
    City(provinceID: "29", cityID: "29056", cityName: "Gaucín", latitude: 36.51924, longitude: -5.31775),
    City(provinceID: "29", cityID: "29057", cityName: "Genalguacil", latitude: 36.54564, longitude: -5.23594),
    City(provinceID: "29", cityID: "29067", cityName: "Málaga", latitude: 36.72130, longitude: -4.42164),
    City(provinceID: "29", cityID: "29068", cityName: "Manilva", latitude: 36.37700, longitude: -5.24898),
    City(provinceID: "29", cityID: "29069", cityName: "Marbella", latitude: 36.50898, longitude: -4.88562),
    City(provinceID: "29", cityID: "29070", cityName: "Mijas", latitude: 36.59575, longitude: -4.63752),
    City(provinceID: "29", cityID: "29071", cityName: "Moclinejo", latitude: 36.77159, longitude: -4.25544),
    City(provinceID: "29", cityID: "29072", cityName: "Mollina", latitude: 37.12587, longitude: -4.65789),
    City(provinceID: "29", cityID: "29073", cityName: "Monda", latitude: 36.63001, longitude: -4.83061),
    City(provinceID: "29", cityID: "29903", cityName: "Montecorto", latitude: 36.81526, longitude: -5.29763),
    City(provinceID: "29", cityID: "29074", cityName: "Montejaque", latitude: 36.73387, longitude: -5.25147),
    City(provinceID: "29", cityID: "29075", cityName: "Nerja", latitude: 36.74686, longitude: -3.87902),
    City(provinceID: "29", cityID: "29076", cityName: "Ojén", latitude: 36.56452, longitude: -4.85650),
    City(provinceID: "29", cityID: "29077", cityName: "Parauta", latitude: 36.65599, longitude: -5.12924),
    City(provinceID: "29", cityID: "29082", cityName: "Rincón de la Victoria", latitude: 36.71621, longitude: -4.27938),
    City(provinceID: "29", cityID: "29083", cityName: "Riogordo", latitude: 36.91528, longitude: -4.29348),
    City(provinceID: "29", cityID: "29084", cityName: "Ronda", latitude: 36.74213, longitude: -5.16659),
    City(provinceID: "29", cityID: "29901", cityName: "Torremolinos", latitude: 36.62428, longitude: -4.49954),
    City(provinceID: "29", cityID: "29091", cityName: "Torrox", latitude: 36.76074, longitude: -3.95237),
    City(provinceID: "29", cityID: "29092", cityName: "Totalán", latitude: 36.76517, longitude: -4.29741),
    City(provinceID: "29", cityID: "29093", cityName: "Valle de Abdalajís", latitude: 36.93117, longitude: -4.68261),
    City(provinceID: "29", cityID: "29094", cityName: "Vélez-Málaga", latitude: 36.78184, longitude: -4.09881),
    City(provinceID: "29", cityID: "29095", cityName: "Villanueva de Algaidas", latitude: 37.18313, longitude: -4.44997),
    City(provinceID: "29", cityID: "29902", cityName: "Villanueva de la Concepción", latitude: 36.93190, longitude: -4.53045),

]
