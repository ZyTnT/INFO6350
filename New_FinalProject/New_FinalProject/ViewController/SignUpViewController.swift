//
//  SignUpViewController.swift
//  New_FinalProject
//
//  Created by Yutong Zhen on 12/10/21.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRePassword: UITextField!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var imgSignUp: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imgSignUp.image = UIImage(named: "Signup")
        // Do any additional setup after loading the view.
    }

    
    @IBAction func SignUpAction(_ sender: Any) {
        let userName = txtUserName.text
        let password = txtPassword.text
        let rePassword = txtRePassword.text
        
        if userName?.count == 0{
            UIAlertController.showAlert(message: "Please input Email", in: self)
        }else if password?.count == 0{
            UIAlertController.showAlert(message: "Please input Password", in: self)
        }else if rePassword?.count == 0{
            UIAlertController.showAlert(message: "Please input password again", in: self)
        }else if rePassword != password{
            UIAlertController.showAlert(message: "Two password aren't same", in: self)
            return
        }else if isValidEmail(userName!) == false{
            UIAlertController.showAlert(message: "Please input a valid email", in: self)
            return
        }else{
            Auth.auth().createUser(withEmail: userName!, password: password!) { [weak self] authResult, error in
                guard let self = self else { return }
                if error != nil{
                    UIAlertController.showAlert(message: error!.localizedDescription, in: self)
                    return
                }else{
                    UIAlertController.showAlert(message: "Create account sucessfully!", in: self)
                }
            }
        }
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
}
