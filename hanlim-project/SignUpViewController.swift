//
//  SignUpViewController.swift
//  hanlim-project
//
//  Created by 이정연 on 2023/06/11.
//

import UIKit
import Firebase
import FirebaseAuth
import Toast

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    var style = ToastStyle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style.messageColor = .blue
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButtonTouched(_ sender: UIButton) {
        Auth.auth()
            .createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] res, error in
                guard let self = self else { return }
                if let error = error {
                    self.view.makeToast("sign up falied")
                } else {
                    // 회원가입에 성공했다면 여기서 처리...
                    self.view.makeToast("sign up success")
                    self.navigationController?.popViewController(animated: true)
                }
            }
    }


}
