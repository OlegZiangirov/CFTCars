//
//  CarsViewController.swift
//  CFT.Cars
//
//  Created by Ziangirov on 23/02/2019.
//  Copyright © 2019 com.oleg.ziangirov. All rights reserved.
//

import UIKit

final class CarsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private lazy var cars = Cars.sharedInstance
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Launcher.setAlreadyUsed()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ShowCarPreviewVC":
            if let indexPathOfSelectedCell = tableView.indexPathForSelectedRow,
                let desination = segue.destination.contents as? CarPreviewViewController {
                let car = cars.getCars()[indexPathOfSelectedCell.row]
                desination.setup(car: car)
            }
        case "ShowCarAddVC":
            if let desination = segue.destination.contents as? CarEditTableViewController {
                let newCar = Car()
                desination.setup(car: newCar)
                desination.setupCancelButton()
            }
        default:
            break
        }
    }
    
    @IBAction func done(bySegue: UIStoryboardSegue) {
    }
    
}

extension CarsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.getCars().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarCellReuseID", for: indexPath)
            if let carCell = cell as? CarTableViewCell {
                carCell.setup(car: cars.getCars()[indexPath.row])
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.performBatchUpdates({ [weak self] in
                tableView.deleteRows(at: [indexPath], with: .fade)
                if let removedCar = self?.cars.getCars()[indexPath.row] {
                    self?.cars.removeCar(removedCar)
                }
            })
            
        } else if editingStyle == .insert {
            
        }
    }
    
}

extension CarsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? navcon
        } else {
            return self
        }
    }
    
}
