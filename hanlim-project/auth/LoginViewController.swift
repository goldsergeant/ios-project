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

    }
    @IBAction func signUpButtonTouched(_ sender: UIButton) {
        //화면전환버튼
         guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SignUpViewController") else {return}
         self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func loginButtonTouched(_ sender: UIButton) {
        // Firebase 인증 로직 수행 (예: 이메일/비밀번호 인증)
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] (_, error) in
               guard let self = self else { return }
               
               if let error = error {
                   // 로그인 실패 처리
                   self.view.makeToast("login failed")
               } else {
                   
                   // 메인 화면으로 전환
                   let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                   mainVC.modalPresentationStyle = .fullScreen
                   self.present(mainVC,animated: true,completion: nil)
               }
           }
    }
    

}

extension LoginViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if Auth.auth().currentUser != nil {
            // 메인 화면으로 전환
            let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            mainVC.modalPresentationStyle = .fullScreen
            self.present(mainVC,animated: true,completion: nil)
        } else {
          // No user is signed in.
          // ...
        }
    }
}
