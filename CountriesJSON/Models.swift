//
//  Country.swift
//  CountriesJSON
//
//  Created by Vladimir Kratinov on 2022/2/4.
//

import Foundation

struct Country: Codable {
    var name: String
    var id: String
    var image1Description: String
    var image2Description: String
    var population: Double
    var area: Double
    var capital: String
    var language: String
    var description: String
    var background: String
    var political: String
    var export: String
}
