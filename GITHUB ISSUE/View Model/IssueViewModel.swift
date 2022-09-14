//
//  IssueViewModel.swift
//  GITHUB ISSUE
//
//  Created by Naba Riaz on 9/9/22.
//

import Foundation

/// This class is the view model that contains all the business logic
class IssueViewModel: APIHandlerDelegate {
    var error: String?
    var arr: [Issue]? //create an array of issues
    var delegate: IssueViewModelProtocol?
    var apiHandler = APIHandler.init()
    
    /// This function gets the error if any
    /// - Returns: variable error of type optional string which imay be generated
    func getError() -> String? {
        return error
    }
    
    /// This function gets the data from the APIHandler using the URL constant in the enum
    func getDataFromAPI() {
        apiHandler.delegate = self
        guard let url = URL(string: Server.ISSUE_URL.rawValue) else { return }
        apiHandler.getDataFromServer(from: url, of: [Issue].self)
    }
    
    /// This function checks that if the data fetching is finished, then assign the array to the result
    /// - Parameters:
    ///   - result: fetched objects
    ///   - error: error if any generated
    func didFinishGettingData(result: Decodable?, error: String?) {
        guard let result = result as? [Issue] else {
            print(error ?? "")
            return
        }
        
        ///set array equal to result and type cast as issue
        arr = result
        self.error = error
        
        delegate?.finishedGettingData()
    }
    
    /// This function returns the array count that now contains fetched data
    /// - Returns: number of elements in array
    func getRowCount() -> Int {
        return arr?.count ?? 0
    }
    
    /// This function returns content for each cell in the table using arr[row] where row is the indexPath.row
    /// - Parameter row: index
    /// - Returns: string content to be displayed
    func getDataForCell(row: Int) -> String {
        return "url: \(arr?[row].url ?? "")\ntitle: \(arr?[row].url ?? "")\nlogin: \(arr?[row].user?.login ?? "")\nstate: \(arr?[row].state ?? "")\ncomments: \(arr?[row].comments ?? 0)\ncreated_at: \(arr?[row].created_at ?? "")"
    }
}

/// Protocol delegate: This protocol has a blueprint of the method that the view controller conforms to and implements it
protocol IssueViewModelProtocol {
    /// This function reloads the table to update it with the decoded data if the decoding was successful and there are no errors
    func finishedGettingData()
}
