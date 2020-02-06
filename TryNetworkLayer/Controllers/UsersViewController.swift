//
//  ViewController.swift
//  TryNetworkLayer
//
//  Created by Andrea on 30/12/2019.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import UIKit

class UsersViewController: UITableViewController {
    
    // MARK: Properties
    
    let viewModel = UsersViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: View Management
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupObservers()
        setupSearchController()
        viewModel.fecthUsers()
    }
    
    func setupObservers() {
        _ = viewModel.updateView.observeNext { [unowned self] (updateView) in
            if updateView {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    // MARK: Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfUsers()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user_cell", for: indexPath)
        
        let user = viewModel.userAt(indexPath: indexPath)
        cell.textLabel?.text = user.login
        cell.detailTextLabel?.text = user.type
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
        let user = viewModel.userAt(indexPath: indexPath)
        vc.viewModel = UserDetailViewModel(userLogin: user.login!)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension UsersViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let filter = searchBar.text?.lowercased() else { return }
        viewModel.searchUsers(query: filter)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.fecthUsers()
    }
}

extension UsersViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {

    }
}
