//
//  BeachList.swift
//  ClimaEs
//
//  Created by Sergei Kornilov on 30/03/2024.
//

import Foundation

// MARK: - Malas prácticas: deben transferirse a la base de datos

public struct Beach: Codable {
    public var beachId: String
    public var beachName: String
    public var cityName: String
    public var regionName: String
    public var latitude: Double
    public var longitude: Double
    
    public init(beachId: String, beachName: String, cityName: String, regionName: String, latitude: Double, longitude: Double) {
        self.beachId = beachId
        self.beachName = beachName
        self.cityName = cityName
        self.regionName = regionName
        self.latitude = latitude
        self.longitude = longitude
    }
}


let beaches = [
    Beach(beachId: "2902503", beachName: "Bil-Bil y Arroyo de la Miel", cityName: "Benalmádena", regionName: "Málaga", latitude: 36.588223, longitude: -4.5301228),
    Beach(beachId: "2902514", beachName: "Carvajal", cityName: "Benalmádena", regionName: "Málaga", latitude: 36.57248, longitude: -4.5880723),
    Beach(beachId: "2904101", beachName: "Ancha", cityName: "Casares", regionName: "Málaga", latitude: 36.37565, longitude: -5.22028),
    Beach(beachId: "2905106", beachName: "La Rada", cityName: "Estepona", regionName: "Málaga", latitude: 36.418743, longitude: -5.152139),
    Beach(beachId: "2905402", beachName: "Los Boliches - Las Gaviotas", cityName: "Fuengirola", regionName: "Málaga", latitude: 36.554382, longitude: -4.611625),
    Beach(beachId: "2906707", beachName: "La Malagueta", cityName: "Málaga", regionName: "Málaga", latitude: 36.71706, longitude: -4.4102783),
    Beach(beachId: "2906712", beachName: "El Dedo - El Chanquete", cityName: "Málaga", regionName: "Málaga", latitude: 36.716557, longitude: -4.3485537),
    Beach(beachId: "2906801", beachName: "Sabinillas", cityName: "Manilva", regionName: "Málaga", latitude: 36.370975, longitude: -5.223011),
    Beach(beachId: "2906906", beachName: "Río Verde - Puerto Banús", cityName: "Marbella", regionName: "Málaga", latitude: 36.48983, longitude: -4.949057),
    Beach(beachId: "2906912", beachName: "La Bajadilla", cityName: "Marbella", regionName: "Málaga", latitude: 36.507805, longitude: -4.8771873),
    Beach(beachId: "2906921", beachName: "Alicante (Costa Bella - Pinomar)", cityName: "Marbella", regionName: "Málaga", latitude: 36.499382, longitude: -4.819905),
    Beach(beachId: "2907002", beachName: "La Butibamba", cityName: "Mijas", regionName: "Málaga", latitude: 36.499237, longitude: -4.684071),
    Beach(beachId: "2907502", beachName: "Torrecilla", cityName: "Nerja", regionName: "Málaga", latitude: 36.741814, longitude: -3.8824775),
    Beach(beachId: "2907509", beachName: "Burriana", cityName: "Nerja", regionName: "Málaga", latitude: 36.750385, longitude: -3.8664434),
    Beach(beachId: "2908202", beachName: "Rincón de la Victoria", cityName: "Rincón de la Victoria", regionName: "Málaga", latitude: 36.71469, longitude: -4.288793),
    Beach(beachId: "2909103", beachName: "Las Lindes", cityName: "Torrox", regionName: "Málaga", latitude: 36.731457, longitude: -3.9752405),
    Beach(beachId: "2909406", beachName: "Torre del Mar", cityName: "Vélez-Málaga", regionName: "Málaga", latitude: 36.741383, longitude: -4.0885553),
    Beach(beachId: "2990102", beachName: "El Bajondillo (Playamar)", cityName: "Torremolinos", regionName: "Málaga", latitude: 36.627083, longitude: -4.491582),
]
