//
//  AddLocationViewController.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/21.
//

import UIKit
import CoreLocation

protocol AddLocationViewControllerDelegae {
    func controller(_ controller: AddLocationViewController, didAddLocation location: Location)
}

class AddLocationViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var locations: [Location] = []
    
    private lazy var geocoder = CLGeocoder()
    
    var delegate: AddLocationViewControllerDelegae?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Add a location"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchBar.becomeFirstResponder()
    }

    private func geocode(address: String?) {
        guard let address = address else {
            locations = []
            tableView.reloadData()
            
            return
        }
        
        geocoder.geocodeAddressString(address) { [weak self] placemarks, error in
            DispatchQueue.main.async {
                self?.processResponse(with: placemarks, error: error)
            }
        }
    }
    
    private func processResponse(with placemarks: [CLPlacemark]?, error: Error?) {
        if let error = error {
            print("Cannot handle Geocode Address! \(error)")
        }
        else if let results = placemarks {
            locations = results.compactMap {
                guard let name = $0.name else { return nil }
                guard let location = $0.location else { return nil }
                
                return Location(name: name, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            }
            
            tableView.reloadData()
        }
    }
}

extension AddLocationViewController {
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.reuseIdentitifier, for: indexPath) as? LocationTableViewCell else {
            fatalError("Unexpected table view cell")
        }

        let location = locations[indexPath.row]
        let vm = LocationsViewModel(location: location.location, locationText: location.name)
        
        cell.configure(with: vm)

        return cell
    }

   // MARK: = Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = locations[indexPath.row]
        
        delegate?.controller(self, didAddLocation: location)
        
        navigationController?.popViewController(animated: true)
    }
}

extension AddLocationViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        geocode(address: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        locations = []
        tableView.reloadData()
    }
}
