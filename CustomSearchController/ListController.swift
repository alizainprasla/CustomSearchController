//
//  ViewController.swift
//  CustomSearchController
//
//  Created by Ali Zain on 29/01/2020.
//  Copyright © 2020 Ali Zain. All rights reserved.
//

import UIKit

class ListController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var filterHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var filterView:UIView!
    
    var searchViewController:UIViewController?
    var searchController:UISearchController?
    
    var uilabel : UILabel?
    var tableData = [Int](repeating: 0, count: 10)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List"
        searchViewController = getSearchController()
        searchController = UISearchController(searchResultsController: searchViewController)
        setupSearchController()
    }
    
    override func viewDidLayoutSubviews() {
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setupSearchController(){
        
        searchController?.searchResultsUpdater = self
        searchController?.obscuresBackgroundDuringPresentation = false
        searchController?.searchBar.placeholder = "Search"
        searchController?.searchBar.delegate = self
        definesPresentationContext = true
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = true
        } else {
            let leftNavBarButton = UIBarButtonItem(customView:(searchController?.searchBar)!)
            self.navigationItem.leftBarButtonItem = leftNavBarButton
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let data = tableData[indexPath.row]
        cell.textLabel?.text = "\(data)"
        return cell
    }
    
    func getSearchController() -> UIViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchControllerViewController_ID")
        return vc
    }
    
    var didEndEditing = false
    var isSearching = false
    
}


extension ListController : UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        /*if !didEndEditing {
            self.view.layoutIfNeeded()
            self.tableView.layoutIfNeeded()
            UIView.animate(withDuration: 0.3) {
                let rect = CGRect(x: 0, y: 0, width: 40, height: 40)
                let uilabel = UILabel.init(frame: rect)
                uilabel.text = "HELLP"
                uilabel.backgroundColor = .white
                self.tableView.tableHeaderView = uilabel
            }
        }
        */
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        didEndEditing = false
        isSearching = true
//        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
//
//        }, completion: {
//            self.filterHeightConstraint.constant = 50
//            self.filterView.layoutIfNeeded()
//        })
        self.filterHeightConstraint.constant = 50
        self.filterView.alpha = 1
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
            self.filterView.layoutIfNeeded()
        }) { (completed) in
            if completed {
//            self.tableView.reloadData()
            }
        }
        
        
        

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        didEndEditing = true
        isSearching = false
        self.filterHeightConstraint.constant = 0
        self.filterView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.filterView.layoutIfNeeded()
        }) { (completed) in
            if completed {
//                self.tableView.reloadData()
            }
        }
        
    }
    

    
    
}

