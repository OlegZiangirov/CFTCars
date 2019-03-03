//
//  Cars.swift
//  CFT.Cars
//
//  Created by Ziangirov on 24/02/2019.
//  Copyright © 2019 com.oleg.ziangirov. All rights reserved.
//

import Foundation

class Cars {
    private init() { }
    
    private static let name = String(describing: Cars.self)
    
    static let sharedInstance: Cars = {
        let instance = Cars()
        
        if let defaultCars = Launcher.getDefaultCars() {
            instance.store(cars: defaultCars)
        }
        return instance
    }()

    func getCars() -> [Car] {
        return loadCars() ?? []
    }
    
    func addCar(_ car: Car) {
        var cars = loadCars() ?? []
        
        if let oldCar = getCar(id: car.id),
            let index = cars.firstIndex(of: oldCar) {
            cars[index] = car
        } else {
            cars.append(car)
        }
        
        store(cars: cars)
        
    }
    
    func removeCar(_ car: Car) {
        var cars = loadCars() ?? []
        if let index = cars.firstIndex(of: car) {
            cars.remove(at: index)
            store(cars: cars)
        }
    }
    
    func getCar(id: String) -> Car? {
        return getCars().filter { $0.id == id }.first
    }
    
}


extension Cars {
    private func getJSON(cars: [Car]) -> Data? {
        return try? JSONEncoder().encode(cars)
    }
    private func decode(json: Data) -> [Car]? {
        return try? JSONDecoder().decode([Car].self, from: json)
    }
    private func store(cars: [Car]) {
        _ = getJSON(cars: cars)?.storeLocallyAsJSON(named: Cars.name)
    }
    private func loadCars() -> [Car]? {
        if let path = Data.urlToStoreLocallyAsJSON(named: Cars.name) {
            if let data = try? Data(contentsOf: path) {
                if let savedCars = self.decode(json: data) {
                    return savedCars
                }
            }
        }
        return nil
    }
    
}

extension Data {
    private static let localDataDirectory = "JSON.storeLocallyAsJSON"
 
    static func urlToStoreLocallyAsJSON(named: String) -> URL? {
        var name = named
        let pathComponents = named.components(separatedBy: "/")
        if pathComponents.count > 1 {
            if pathComponents[pathComponents.count - 2] == localDataDirectory {
                name = pathComponents.last!
            } else {
                return nil
            }
        }
        if var url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
            url = url.appendingPathComponent(localDataDirectory)
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
                url = url.appendingPathComponent(name)
                if url.pathExtension != "json" {
                    url = url.appendingPathExtension("json")
                }
                return url
            } catch let error {
                print("Data.urlToStoreLocallyAsJSON \(error)")
            }
        }
        return nil
    }
    
}

extension Data {
    func storeLocallyAsJSON(named name: String) -> URL? {
        if let url = Data.urlToStoreLocallyAsJSON(named: name) {
            do {
                try self.write(to: url)
                return url
            } catch let error {
                print("Data.storeLocallyAsJSON \(error)")
            }
        }
        return nil
    }
    
}



