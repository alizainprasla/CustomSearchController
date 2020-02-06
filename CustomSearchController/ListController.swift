//
//  ViewController.swift
//  CustomSearchController
//
//  Created by Ali Zain on 29/01/2020.
//  Copyright © 2020 Ali Zain. All rights reserved.
//

import UIKit

class ListController : UITableViewController {
    
    var searchViewController:UIViewController?
    var searchController:UISearchController?
    
    var uilabel : UILabel?
    var tableData = [Int](repeating: 0, count: 10)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List"
        searchViewController = getSearchController()
        searchController = UISearchController(searchResultsController: searchViewController)
        
//        let height = searchController?.searchBar.frame.height ?? 40
//        let rect = CGRect(x: 0, y:height, width: 100, height: 30)
//        if let bar = searchController?.searchBar {
//            let customView = UIView.init(frame: rect)
//            customView.backgroundColor = .red
//            customView.translatesAutoresizingMaskIntoConstraints = false
//            searchController?.searchBar.addSubview(customView)
//            customView.topAnchor.constraint(equalTo: bar.topAnchor,constant: 20).isActive = true
//            customView.bottomAnchor.constraint(equalTo: bar.bottomAnchor).isActive = true
//            customView.leftAnchor.constraint(equalTo: bar.leftAnchor).isActive = true
//            customView.rightAnchor.constraint(equalTo: bar.rightAnchor).isActive = true
//        }
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let data = tableData[indexPath.row]
        cell.textLabel?.text = "\(data)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if isSearching {
            let rect = CGRect(x: 0, y: 0, width: 50, height: 40)
            let xib = FilterScrollView.getXIB()
            xib.frame = rect
            return xib
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if  isSearching {
            return 40
        }
        
        return 0
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
        self.tableView.reloadData()

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        didEndEditing = true
        isSearching = false
        
 
        self.tableView.tableHeaderView = nil
        tableView.beginUpdates()
        UIView.animate(withDuration: 0.4) {
            self.tableView.tableHeaderView?.frame.size.height = 0
            self.tableView.tableHeaderView?.layoutIfNeeded()
        }
        tableView.endUpdates()
        
    }
    

    
    
}
