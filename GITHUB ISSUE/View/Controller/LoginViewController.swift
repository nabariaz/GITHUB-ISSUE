//
//  LoginViewController.swift
//  GITHUB ISSUE
//
//  Created by Naba Riaz on 9/16/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        if usernameTF.text == "naba" && passwordTF.text == "riaz" {
            //Navigate to Issue View Controller
            let issueVC = self.storyboard?.instantiateViewController(withIdentifier: "IssueViewController") as? IssueViewController
            
            //Save the information and pass it to next screen
            let userDefault = UserDefaults.standard
            userDefault.set(usernameTF.text, forKey: "firstName")
            userDefault.set(passwordTF.text, forKey: "lastName")
            
            if let issueVC = issueVC {
                self.navigationController?.pushViewController(issueVC, animated: true)
            }
        }
    }
}
