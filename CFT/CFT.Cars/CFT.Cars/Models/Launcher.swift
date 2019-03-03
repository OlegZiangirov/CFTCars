//
//  Launcher.swift
//  CFT.Cars
//
//  Created by Ziangirov on 03/03/2019.
//  Copyright © 2019 com.oleg.ziangirov. All rights reserved.
//

import Foundation

enum Launcher: Int {
    case firstLaunch, alreadyUsed
    
    private static let launcherKey = "launcherKey"
    
    static func setAlreadyUsed() {
        UserDefaults.standard.set(Launcher.alreadyUsed.rawValue, forKey: Launcher.launcherKey)
    }
    
    static func setFirstLaunch() {
        UserDefaults.standard.set(Launcher.firstLaunch.rawValue, forKey: Launcher.launcherKey)
    }
    
    static func getDefaultCars() -> [Car]? {
        return Launcher(rawValue: UserDefaults.standard.integer(forKey: Launcher.launcherKey))!.cars
    }
    
    private var cars: [Car]? {
        switch self {
        case .firstLaunch:
            return [
                Car(issueYear: "2000",
                    model: "Kalina",
                    manufacturer: "Lada",
                    classOfCar: "B",
                    typeOfBody: "Hatchback"),
                Car(issueYear: "2010",
                    model: "Priora",
                    manufacturer: "Lada",
                    classOfCar: "B",
                    typeOfBody: "Sedan"),
                Car(issueYear: "2019",
                    model: "Vesta",
                    manufacturer: "Lada",
                    classOfCar: "C",
                    typeOfBody: "Hatchback")
            ]
        case .alreadyUsed:
            return nil
        }
    }
    
}
