//
//  Car.swift
//  CFT.Cars
//
//  Created by Ziangirov on 23/02/2019.
//  Copyright © 2019 com.oleg.ziangirov. All rights reserved.
//

import Foundation

struct Car: Codable {
    let id: String
    
    var issueYear: String
    var model: String
    var manufacturer: String
    var classOfCar: String
    var typeOfBody: String
    
    init() {
        id = UUID().uuidString
        
        self.issueYear = ""
        self.model = ""
        self.manufacturer = ""
        self.classOfCar = ""
        self.typeOfBody = ""
    }
    
    init(issueYear: String, model: String, manufacturer: String, classOfCar: String, typeOfBody: String) {
        self.init()
        
        self.issueYear = issueYear
        self.model = model
        self.manufacturer = manufacturer
        self.classOfCar = classOfCar
        self.typeOfBody = typeOfBody
    }
    
}

extension Car: Equatable {
    static func == (lhs: Car, rhs: Car) -> Bool { return lhs.id == rhs.id }
}

extension Car {
    static let fieldsCount = 5
    
    var description: String {
        return "\(issueYear) \(model) \(manufacturer) \(classOfCar) \(typeOfBody)"
    }
    
    var descriptionFields: [String] {
        return [
            "IssueYear: \(issueYear)",
            "Model: \(model)",
            "Manufacturer: \(manufacturer)",
            "Class: \(classOfCar)",
            "Type: \(typeOfBody)"
        ]
    }
    
    var isValidToSave: Bool {
        return fieldValues.filter { !$0.isEmpty }.count == Car.fieldsCount
    }
    
    private var fieldValues: [String] {
        return Mirror(reflecting: self).children.dropFirst().map { $0.value as? String ?? "" }
    }
    
}
