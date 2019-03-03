//
//  CarEditTableViewController.swift
//  CFT.Cars
//
//  Created by Ziangirov on 03/03/2019.
//  Copyright © 2019 com.oleg.ziangirov. All rights reserved.
//

import UIKit

class CarEditTableViewController: UITableViewController {
    
    private var id: String!
    private var car: Car! { return Cars.sharedInstance.getCar(id: id) }
    private var carForSave: Car!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setup(car: Car) {
        id = car.id
        carForSave = car
    }
    
    func setupCancelButton() {
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissSelf))
        navigationItem.leftBarButtonItem = cancel
    }
    
    @objc func dismissSelf() {
        dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        guard carForSave.isValidToSave else { return }
        
        Cars.sharedInstance.addCar(carForSave)
        dismissSelf()
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Car.fieldsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreviewInputCell", for: indexPath)
        if let inputCell = cell as? CarPreviewInputTableViewCell {
            inputCell.setup(text: carForSave.descriptionFields[indexPath.row])
            
            inputCell.resignationHandler = { [weak self, unowned inputCell] in
                if let text = inputCell.textField.text?.capitalized {
                    switch indexPath.row {
                    case 0:
                        self?.carForSave.issueYear = text
                    case 1:
                        self?.carForSave.model = text
                    case 2:
                        self?.carForSave.manufacturer = text
                    case 3:
                        self?.carForSave.classOfCar = text
                    case 4:
                        self?.carForSave.typeOfBody = text
                    default:
                        break
                    }
                    tableView.reloadData()
                }
            }
        }
        return cell
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

