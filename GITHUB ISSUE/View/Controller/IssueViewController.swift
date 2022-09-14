//
//  ViewController.swift
//  GITHUB ISSUE
//
//  Created by Naba Riaz on 9/9/22.
//

import UIKit

/// This class is the view and is responsible for the user interface
class IssueViewController: UIViewController, IssueViewModelProtocol {
    
    /// This is an initializer of the view model
    let vm = IssueViewModel.init()

    /// This is an IBOutlet of the tableview where the deoded array is going to be displayed
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .dark //dark theme
        
        tblView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "cell") ///register custom cell
        
        vm.delegate = self ///set the delegate to vc
        vm.getDataFromAPI() ///fetch data from the url using view model
    }
    
    /// This function reloads the table to update it with the decoded data if the decoding was successful and there are no errors
    func finishedGettingData() {
        let err = vm.getError()
        
        DispatchQueue.main.async {
            if err == nil {
                self.tblView.reloadData() ///update table with fetched data
            } else {
                print(err.debugDescription) ///data not fetched correctly
            }
        }
    }
}

extension IssueViewController: UITableViewDelegate, UITableViewDataSource {
    
    /// This function fetches the  number of rows in the table using the getRowCount() method is vm
    /// - Parameters:
    ///   - tableView: The table view created and attached using IBOutlet
    ///   - section: Number of sections
    /// - Returns: Number of cells according to array count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.getRowCount()
    }
    
    /// This function populates the cells in the table with the fetched data using the getDataForCell method from view model
    /// - Parameters:
    ///   - tableView: The table view created and attached using IBOutlet
    ///   - indexPath: Get and display the data at a specific row/index
    /// - Returns: The custom cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        ///create a cell as the CustomCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCell
        
        ///access the data to be shown in the cell feom the vm
        let issue = vm.getDataForCell(row: indexPath.row)
        
        cell.lbl.text = issue
        cell.lbl.textColor = .white
        
        return cell
    }
    
    /// This function sets a fixed height for the cell to make it more spacious
    /// - Parameters:
    ///   - tableView: The table view created and attached using IBOutlet
    ///   - indexPath: Get and display the data at a specific row/index
    /// - Returns: A float that will be each cell's height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225.0
    }
}

