//
//  LocationsViewController.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/21.
//

import UIKit
import CoreLocation

protocol LocationsViewControllerDelegae {
    func controller(_ controller: LocationsViewController, didSelectLocation location: CLLocation)
}

class LocationsViewController: UITableViewController {
    private let segueAddLocationView = "SegueAddLocationView"
    
    var delegate: LocationsViewControllerDelegae?
    
    var currentLocation: CLLocation?
    
    var favourites = UserDefaults.loadLoactions()
    
    private var hasFavourites: Bool {
        return favourites.count > 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case segueAddLocationView:
            let dest = segue.destination
            if let addLocationViewController = dest as? AddLocationViewController {
                addLocationViewController.delegate = self
            }
            else {
                fatalError("Unexpected destination view controller.")
            }
        default:
            break
        }
    }

}

extension LocationsViewController {
    private enum Section: Int {
        case current
        case favourite
        
        var title: String {
            switch self {
            case .current:
                return "Current Location"
            case .favourite:
                return "Favourite Locations"
            }
        }
        
        static var count: Int {
            return Section.favourite.rawValue + 1
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else {
            fatalError("Unexpected Section")
        }
        
        switch section {
        case .current:
            return 1
        case .favourite:
            return max(favourites.count, 1)
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section(rawValue: section) else {
            fatalError("Unexpected Section")
        }
        
        return section.title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unexpected Section")
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.reuseIdentitifier, for: indexPath) as? LocationTableViewCell else {
            fatalError("Unexpected table view cell")
        }
        
        var vm: LocationsViewModel?
        
        switch section {
        case .current:
            if let currentLocation = currentLocation {
                vm = LocationsViewModel(location: currentLocation, locationText: nil)
            }
            else {
                cell.label.text = "Current Location Unknown"
            }
        case .favourite:
            if favourites.count > 0 {
                let fav = favourites[indexPath.row]
                vm = LocationsViewModel(location: fav.location, locationText: fav.name)
            }
            else {
                cell.label.text = "No Favourites Yet ..."
            }
        }
        
        if let vm = vm {
            cell.configure(with: vm)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unexpected Section")
        }
        
        switch section {
        case .current:
            return false
        case .favourite:
            return hasFavourites
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let location = favourites[indexPath.row]
        UserDefaults.removeLocation(location)
        
        favourites.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unexpected Section")
        }
        
        var location: CLLocation?
        
        switch section {
        case .current:
            if let currentLocation = currentLocation {
                location = currentLocation
            }
        case .favourite:
            if hasFavourites {
                location = favourites[indexPath.row].location
            }
        }
        
        if location != nil {
            delegate?.controller(self, didSelectLocation: location!)
            dismiss(animated: true)
        }
    }
}

extension LocationsViewController: AddLocationViewControllerDelegae {
    func controller(_ controller: LocationsViewController, didAddLocation location: Location) {
        UserDefaults.addLocation(location)
        
        favourites.append(location)
        
        
    }
}
