//
//  FirstViewController.swift
//  BIHackathon
//
//  Created by Renee Leung on 2016-11-26.
//  Copyright © 2016 Renee Leung. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    
    lazy var searchBar: UISearchBar = UISearchBar()
    var resultsTableView : UITableView = UITableView()
    
    var patients: [Patient] = []
    
    var filteredPatients = [Patient]()
    
    struct MyString {
        static func contains(_ text: String, substring: String,
                             ignoreCase: Bool = true,
                             ignoreDiacritic: Bool = true) -> Bool {
            
            var options = NSString.CompareOptions()
            
            if ignoreCase { _ = options.insert(NSString.CompareOptions.caseInsensitive) }
            if ignoreDiacritic { _ = options.insert(NSString.CompareOptions.diacriticInsensitive) }
            
            return text.range(of: substring, options: options) != nil
        }
    }
    
    

    func reloadPatientInfo() {
        resultsTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = UITableViewCell()
  //      if tableViewCell == self.searchDisplayController!.searchResultsTableView {
   //         patients[indexPath.row] = filteredPatients[indexPath.row]
  //      } else {
    //        patients[indexPath.row] = patients[indexPath.row]
      //  }
        
        tableViewCell.textLabel?.text = patients[indexPath.row].name + "              Risk Factor: " + String(patients[indexPath.row].riskFactor)
        if patients[indexPath.row].riskFactor <= 30 {
            tableViewCell.backgroundColor = UIColor.green
        }else if patients[indexPath.row].riskFactor <= 60 {
            tableViewCell.backgroundColor = UIColor.yellow
        }else{
            tableViewCell.backgroundColor = UIColor.red
        }
        
        
   //           if searchController.isActive && searchController.searchBar.text != "" {
     //       let index = filteredPatients.index(after:)(indexPath.row)
       //     tableViewCell.textLabel!.text = filteredPatients[index]
      //  } else {
       //     let index = patients.index(after:)(indexPath.row)
       //     tableViewCell.textLabel!.text = patients[index]
       // }

        return tableViewCell
        
    }
    @IBOutlet var tableView: UITableView!
    
  //  func search(searchText: String) {
    //    let temp = patients.filter({patient  in
      //      return MyString.contains(patient.name.lowercased(), substring: searchText.lowercased())
        //})
       // filteredPatients.removeAll() // clear previous ones
        //for patient in temp { filteredPatients[patient.1] = patient.2 }
       // resultsTableView.reloadData()
    //}
  //  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    //    updateSearchResultsForSearchController(searchController: searchController)
//    }
  //  func updateSearchResultsForSearchController(searchController: UISearchController) {
    //    search(searchText: searchController.searchBar.text!)
   // }
    
        func searchDisplayController(searchController: UISearchController) {
          let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchText: searchController.searchBar.text!, scope: scope)
    }

    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredPatients = patients.filter { patient in
        print(MyString.contains(patient.name.lowercased(), substring: searchText.lowercased()))
        return MyString.contains(patient.name.lowercased(), substring: searchText.lowercased())
        }
    resultsTableView.reloadData()
        }
    
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        searchBar.searchBarStyle = UISearchBarStyle.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        
        
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        resultsTableView.tableHeaderView = searchController.searchBar
        
        
        
        
        resultsTableView.frame = view.bounds
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
        self.view.addSubview(self.resultsTableView)
        
        let patient = Patient()
        patient.id = "1"
        patient.name = "Patient1"
        patient.riskFactor = 10
        patients.append(patient)
        
        let patient2 = Patient()
        patient2.id = "2"
        patient2.name = "Patient2"
        patient2.riskFactor = 100
        patients.append(patient2)
        
        let patient3 = Patient()
        patient3.id = "3"
        patient3.name = "Patient3"
        patient3.riskFactor = 50
        patients.append(patient3)
        
        let patient4 = Patient()
        patient4.id = "4"
        patient4.name = "Patient4"
        patient4.riskFactor = 20
        patients.append(patient4)
        
        let patient5 = Patient()
        patient5.id = "5"
        patient5.name = "Patient5"
        patient5.riskFactor = 75
        patients.append(patient5)
        
        let patient6 = Patient()
        patient6.id = "6"
        patient6.name = "Patient6"
        patient6.riskFactor = 40
        patients.append(patient6)
        
        let patient7 = Patient()
        patient7.id = "7"
        patient7.name = "Patient7"
        patient7.riskFactor = 5
        patients.append(patient7)
        
        let patient8 = Patient()
        patient8.id = "7"
        patient8.name = "Patient8"
        patient8.riskFactor = 42
        patients.append(patient8)
        
        let patient9 = Patient()
        patient9.id = "7"
        patient9.name = "Patient9"
        patient9.riskFactor = 54
        patients.append(patient9)
        
        let patient10 = Patient()
        patient10.id = "7"
        patient10.name = "Patient10"
        patient10.riskFactor = 82
        patients.append(patient10)
        
        let patient11 = Patient()
        patient11.id = "7"
        patient11.name = "Patient11"
        patient11.riskFactor = 36
        patients.append(patient11)
        
        let patient12 = Patient()
        patient12.id = "7"
        patient12.name = "Patient12"
        patient12.riskFactor = 23
        patients.append(patient12)
        
        let patient13 = Patient()
        patient13.id = "7"
        patient13.name = "Patient13"
        patient13.riskFactor = 53
        patients.append(patient13)
        
        
        patients.sort(by: { $0.riskFactor > $1.riskFactor })
        
        
        definesPresentationContext = true
        
        
    }

}
extension UIViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
    }
}
