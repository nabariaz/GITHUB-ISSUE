//
//  APIHandler.swift
//  GITHUB ISSUE
//
//  Created by Naba Riaz on 9/9/22.
//

import Foundation

/// This class manages the networking layer to fetch data from server
class APIHandler {
    
    var delegate: APIHandlerDelegate?
    
    /// This methods checks if the URL is accessable and passes all if tests. If yes, the data in the URL is then decoded using the JSONDecoder
    /// - Parameters:
    ///   - url: URL from which the data is going to be fetched and decoded
    ///   - type: object of type array in this case
    func getDataFromServer<T: Decodable>(from url: URL, of type: T.Type) {
        URLSession.shared.dataTask(with: url) { data, urlresponse, error in
            let statusCodeTask = (urlresponse as? HTTPURLResponse)?.statusCode ?? 200
            
            ///check if all these conditions pass and then decode suing JSONDecoder
            if statusCodeTask == 200 && error == nil && data?.isEmpty == false {
                let jsonDecoder: JSONDecoder = JSONDecoder()
                
                ///try decoding
                guard let data = data, let decodedArr = try? jsonDecoder.decode(type, from: data) else {
                    ///if decoding couldn't be done result is nil and an error is thrown
                    self.delegate?.didFinishGettingData(result: nil, error: "Decoding couldn't be done.")
                    return
                }
                ///if decoding is sucessful, create an arr called decodedArr and populate it with the result
                self.delegate?.didFinishGettingData(result: decodedArr, error: nil)
            }
            ///if an error is encountered and one of the theree conditions, statusCodeTask == 200 && error == nil && data?.isEmpty == false, fails then result is nill and the error description is shown
            else if error != nil {
                self.delegate?.didFinishGettingData(result: nil, error: error.debugDescription)
            }
            ///if it's none of the above issues and decoding still can't be done then result is nil and there is some other problem
            else {
                self.delegate?.didFinishGettingData(result: nil, error: "There is some other problem.")
            }
        }.resume() ///to keep decoding
    }
}

/// Protocol delegate that notifies that data has finished fetching and decoding
protocol APIHandlerDelegate: AnyObject {
    
    /// This function checks that if the data fetching is finished, then assign the array to the result
    /// - Parameters:
    ///   - result: fetched objects
    ///   - error: error if any generated
    func didFinishGettingData(result: Decodable?, error: String?)
}
