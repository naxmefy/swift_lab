//
//  main.swift
//  config-loader
//
//  Created by Mohammed Reiner Wilhelm Neundorf on 16.09.21.
//

import Foundation

struct InstituteConfig: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name,
             age,
             single
    }

    let name: String
    let age: Int
    let single: Bool
}

enum ParsingError: Error {
    case fileNotFound
}

func parseConfig() throws -> InstituteConfig {
    guard let url = Bundle.main.url(forResource: "config", withExtension: "plist") else {
        throw ParsingError.fileNotFound
    }
    
    let decoder = PropertyListDecoder()
    
    let data = try Data(contentsOf: url)
    return try decoder.decode(InstituteConfig.self, from: data)
}

do {
    let config = try parseConfig()
    print(config.name)
    print(config.age)
    print(config.single)
} catch ParsingError.fileNotFound {
    print("File not found")
    exit(1)
}


