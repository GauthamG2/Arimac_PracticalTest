//
//  RegisterViewController.swift
//  Arimac
//
//  Created by Gautham on 2022-09-28.
//

import UIKit
import SwiftKeychainWrapper

class RegisterViewController: UIViewController {

    // MARK: - Variables
    
    // MARK: - Outlets
    
    @IBOutlet weak var usernameTF       : UITextField!
    @IBOutlet weak var passwordTF       : UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var btnRegister      : UIButton!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }

    // MARK: Configure UI
    
    func configUI() {
        btnRegister.layer.cornerRadius = 20
    }
    
    // MARK: Outlet Actions
    
    @IBAction func didTapOnBtnRegister(_ sender: UIButton) {
        if let _username = usernameTF.text, let _password = passwordTF.text, let _confirmPassword = confirmPasswordTF.text {
            if !_username.isEmpty, !_password.isEmpty, !_confirmPassword.isEmpty {
                if _password == _confirmPassword {
                    KeychainWrapper.standard.set(_username, forKey: "Username")
                    KeychainWrapper.standard.set(_password, forKey: "Password")
                    navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
