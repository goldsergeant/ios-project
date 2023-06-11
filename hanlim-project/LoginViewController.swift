//
//  LoginViewController.swift
//  hanlim-project
//
//  Created by 이정연 on 2023/06/11.
//

import UIKit
import Firebase
import Toast

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField:UITextField!
    @IBOutlet weak var passwordTextField:UITextField!
    

    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    var style = ToastStyle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style.messageColor = .blue
        
        if let user = Auth.auth().currentUser {

            emailTextField.placeholder = "이미 로그인 된 상태입니다."

            passwordTextField.placeholder = "이미 로그인 된 상태입니다."

            loginButton.setTitle("이미 로그인 된 상태입니다.", for: .normal)

        }

    }
    
    @IBAction func loginButtonTouched(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if user != nil{
                
                self.view.makeToast("login success")
                
            }
            
            else{
                self.view.makeToast("login fail")
                
            }
        }
    }
    

}
