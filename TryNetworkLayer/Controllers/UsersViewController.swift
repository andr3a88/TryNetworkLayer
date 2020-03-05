//
//  ViewController.swift
//  TryNetworkLayer
//
//  Created by Andrea on 30/12/2019.
//  Copyright © 2019 Andrea Stevanato All rights reserved.
//

import Combine
import UIKit

final class UsersViewController: UITableViewController {
    
    // MARK: Properties

    let searchController = UISearchController(searchResultsController: nil)

    private let viewModel = UsersViewModel()
    private var bindings = Set<AnyCancellable>()
    
    // MARK: View Management
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupObservers()
        setupSearchController()
        viewModel.fecthUsers()
    }
    
    func setupObservers() {

        let updateTableHandler: (Bool) -> Void = { [weak self] state in
            self?.tableView.reloadData()
        }

        viewModel.$updateView
            .receive(on: RunLoop.main)
            .sink(receiveValue: updateTableHandler)
            .store(in: &bindings)
    }
    
    func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleleAllUsers))
    }

    @objc func deleleAllUsers() {
        viewModel.deleleAllUsers()
    }
    
    // MARK: Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfUsers()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user_cell", for: indexPath)
        
        let user = viewModel.userAt(indexPath: indexPath)
        cell.textLabel?.text = user.login
        cell.detailTextLabel?.text = user.type
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userDetailViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
        let user = viewModel.userAt(indexPath: indexPath)
        userDetailViewController.viewModel = UserDetailViewModel(userLogin: user.login)
        self.navigationController?.pushViewController(userDetailViewController, animated: true)
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
