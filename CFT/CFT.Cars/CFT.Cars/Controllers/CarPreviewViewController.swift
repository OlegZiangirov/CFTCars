//
//  CarPreviewViewController.swift
//  CFT.Cars
//
//  Created by Ziangirov on 23/02/2019.
//  Copyright © 2019 com.oleg.ziangirov. All rights reserved.
//

import UIKit

final class CarPreviewViewController: UIViewController {
    
    @IBOutlet weak var carDescriptionTableView: UITableView!
    
    private var id: String!
    private var car: Car! { return Cars.sharedInstance.getCar(id: id) }
    
    func setup(car: Car) {
        id = car.id
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        carDescriptionTableView.reloadData()
    }
    
    @IBAction func editCar(sender: UIBarButtonItem) {
        carDescriptionTableView.reloadData()
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditCar" {
            if let destination = segue.destination.contents as? CarEditTableViewController {
                destination.setup(car: car)
            }
        }
    }

}

extension CarPreviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

extension CarPreviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Car.fieldsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreviewCell", for: indexPath)
        if let previewCell = cell as? CarPreviewTableViewCell {
            previewCell.setup(text: car.descriptionFields[indexPath.row])
        }
        return cell
    }
    
}
