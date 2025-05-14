//
//  ViewController.swift
//  ImageLoading
//
//  Created by Akash Sheelavant on 2/17/25.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func buttonPressed(_ sender: Any) {
        showUsersUsingSwiftUI()
    }
    
    func showUsersUsingUIKit() {
        let service = SearchServices()
        let vieWModel = SearchViewModel(service: service)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let searchViewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController {
        
            searchViewController.viewModel = vieWModel
            vieWModel.searchViewDelegate = searchViewController
            navigationController?.pushViewController(searchViewController, animated: true)
        }
    }
    
    func showUsersUsingSwiftUI() {
        let service = SearchServices()
        let vieWModel = UsersViewModel(service: service)
        
        let viewController = UIHostingController(rootView: UsersList(viewModel: vieWModel))
        navigationController?.pushViewController(viewController, animated: true)
    }
}

