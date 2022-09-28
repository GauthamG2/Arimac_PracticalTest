//
//  LoginViewController.swift
//  Arimac
//
//  Created by Gautham on 2022-09-28.
//

import UIKit
import SwiftKeychainWrapper

class LoginViewController: UIViewController {

    // MARK: - Variables
    
    // MARK: - Outlets
    
    @IBOutlet weak var usernameTF : UITextField!
    @IBOutlet weak var passwordTF : UITextField!
    @IBOutlet weak var btnLogin   : UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    // MARK: Configure UI
    
    func configUI() {
        btnLogin.layer.cornerRadius = 20
        btnRegister.layer.cornerRadius = 20
    }
    
    // MARK: Outlet Actions
    
    @IBAction func didTapOnBtnLogin(_ sender: UIButton) {
        if let _username = usernameTF.text, let _password = passwordTF.text {
            let username = KeychainWrapper.standard.string(forKey: "Username")
            let password = KeychainWrapper.standard.string(forKey: "Password")
            if (_username == username) && (_password == password) {
                ApplicationServiceProvider.shared.resetWindow(in: .Main, for: .MainViewNC, from: self)
            } else {
                self.presentAlert(title: "Alert", message: "Username or password is wrong", buttonTitle: "OK")
                usernameTF.text = ""
                passwordTF.text = ""
            }
        }
    }
    
    @IBAction func didTapOnBtnRegister(_ sender: UIButton) {
        ApplicationServiceProvider.shared.pushToViewController(in: .Authentication, for: .RegisterViewController, from: self)
    }
    
}
