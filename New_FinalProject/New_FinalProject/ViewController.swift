//
//  ViewController.swift
//  New_FinalProject
//
//  Created by 赵芷涵 on 12/10/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var lblStatus: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginAction(_ sender: Any) {
        let email = txtUserName.text
        let password = txtPassword.text
        
        if email?.count == 0{
            lblStatus.text = "Please input email"
        }
        else if isValidEmail(email!) == false{
            lblStatus.text = "Please enter a valid email"
        }
        if password?.count ?? 0 < 5{
            lblStatus.text = "Please input valid password"
        }
    }
    
    @IBAction func signUpAction(_ sender: Any) {
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

