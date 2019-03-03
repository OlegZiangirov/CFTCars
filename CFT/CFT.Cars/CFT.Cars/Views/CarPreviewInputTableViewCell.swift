//
//  CarPreviewInputTableViewCell.swift
//  CFT.Cars
//
//  Created by Ziangirov on 02/03/2019.
//  Copyright © 2019 com.oleg.ziangirov. All rights reserved.
//

import UIKit

class CarPreviewInputTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }
    
    var resignationHandler: (() -> Void)?
    
    func setup(text: String) {
        titleLabel.text = text
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        resignationHandler = nil
        titleLabel.text = nil
        textField.text = nil
    }

}

extension CarPreviewInputTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        resignationHandler?()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
