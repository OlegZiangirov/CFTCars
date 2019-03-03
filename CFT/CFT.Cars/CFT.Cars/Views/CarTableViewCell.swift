//
//  CarTableViewCell.swift
//  CFT.Cars
//
//  Created by Ziangirov on 23/02/2019.
//  Copyright © 2019 com.oleg.ziangirov. All rights reserved.
//

import UIKit

final class CarTableViewCell: UITableViewCell {
    func setup(car: Car) {
        textLabel?.text = car.description
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        textLabel?.text = nil
    }

}
