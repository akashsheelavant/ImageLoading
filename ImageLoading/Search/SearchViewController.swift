//
//  SearchViewController.swift
//  ImageLoading
//
//  Created by Akash Sheelavant on 2/17/25.
//

import UIKit
import Foundation

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SearchViewModelType?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        registerCells()
        viewModel?.fetchRandomUsers()
    }
    
    
    func registerCells() {
        let userCell = UINib(nibName: "UserCell", bundle: nil)
        tableView.register(userCell, forCellReuseIdentifier: "UserCell")
    }
}

extension SearchViewController: SearchViewDelegate {
    func updateUI() {
        tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate {
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.totalUsers ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell {
            if let userViewModel = viewModel?.userViewModel(at: indexPath.row) {
                cell.updateData(userViewModel: userViewModel)
            }
            return cell
        }
        return UITableViewCell()
    }
}
