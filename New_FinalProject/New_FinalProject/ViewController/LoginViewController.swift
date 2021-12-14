//
//  LoginViewController.swift
//  New_FinalProject
//
//  Created by Yutong Zhen on 12/10/21.
//

import UIKit
import FirebaseAuth
import RealmSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var imgLogin: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imgLogin.image = UIImage(named: "Login")
    }

    @IBAction func loginAction(_ sender: Any) {
        let email = txtUserName.text
        let password = txtPassword.text
        if email?.count == 0{
            UIAlertController.showAlert(message: "Please input email", in: self)
        }
        else if isValidEmail(email!) == false{
            UIAlertController.showAlert(message: "Please enter a valid email", in: self)
        }
        Auth.auth().signIn(withEmail: email!, password: password!) { [weak self] authResult, error in
          guard let self = self else { return }
            if error != nil{
                UIAlertController.showAlert(message: error!.localizedDescription, in: self)
                return
            }
            let uid = Auth.auth().currentUser?.uid
            if Auth.auth().currentUser?.uid != nil{
            self.performSegue(withIdentifier: "LoginSegue", sender: self)
            }
        }
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        self.performSegue(withIdentifier: "SignUpSegue", sender: self)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

extension UIAlertController {
    static func showAlert(message: String, in viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .cancel))
        viewController.present(alert, animated: true)
    }
     
    static func showAlert(message: String) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showAlert(message: message, in: vc)
        }
    }
     
    static func showConfirm(message: String, in viewController: UIViewController,
                            confirm: ((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: confirm))
        viewController.present(alert, animated: true)
    }
     
    static func showConfirm(message: String, confirm: ((UIAlertAction)->Void)?) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showConfirm(message: message, in: vc, confirm: confirm)
        }
    }
}
