//
//  CarPreviewTableViewCell.swift
//  CFT.Cars
//
//  Created by Ziangirov on 02/03/2019.
//  Copyright © 2019 com.oleg.ziangirov. All rights reserved.
//

import UIKit

class CarPreviewTableViewCell: UITableViewCell {
    func setup(text: String) {
        textLabel?.text = text
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        textLabel?.text = nil
    }

}
