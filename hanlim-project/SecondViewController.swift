//
//  SecondViewController.swift
//  ch11-hanlim-navigationController
//
//  Created by 이정연 on 2023/05/15.
//

import UIKit

class SecondViewController: UIViewController {
    var text: String?
    
    var firstViewController:FirstViewController?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        secondTextField.text=text
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        firstViewController?.firstTextField.text=secondTextField.text
    }
    
    @IBOutlet weak var secondTextField: UITextField!
    
}
