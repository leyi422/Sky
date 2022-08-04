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

    var viewModel: AddLoctionViewModel!
    var delegate: AddLocationViewControllerDelegae?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Add a location"
        
        viewModel = AddLoctionViewModel()
        
        viewModel.locationsDidChange = { [unowned self] _ in
            self.tableView.reloadData()
        }
        
        viewModel.queryingStatusDidChange = { [unowned self] isQuerying in
            self.title = isQuerying ? "Searching..." : "Add a location"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchBar.becomeFirstResponder()
    }
}

extension AddLocationViewController {
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfLocations
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.reuseIdentitifier, for: indexPath) as? LocationTableViewCell else {
            fatalError("Unexpected table view cell")
        }

        if let viewModel = viewModel.locationViewModel(at: indexPath.row) {
            cell.configure(with: viewModel)
        }
        
        return cell
    }

   // MARK: = Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let location = viewModel.location(at: indexPath.row) else { return }
        
        delegate?.controller(self, didAddLocation: location)
        
        navigationController?.popViewController(animated: true)
    }
}

extension AddLocationViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        viewModel.queryText = searchBar.text ?? ""
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        viewModel.queryText = searchBar.text ?? ""
    }
}
