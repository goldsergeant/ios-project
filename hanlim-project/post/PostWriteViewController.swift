//
//  PostWriteViewController.swift
//  hanlim-project
//
//  Created by 이정연 on 2023/06/14.
//

import UIKit
import FirebaseFirestore

class PostWriteViewController: UIViewController {
    
    let textViewPlaceHolder = "내용을 입력하세요."
    
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    var todayDate: Date = Date()     // 나중에 필요하다
    var postGroup: PostGroup!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.delegate = self
    }
    
    @IBAction func writePost(_ sender: UIBarButtonItem) {
        if titleTextField.text == nil || titleTextField.text?.trimmingCharacters(in: .whitespaces) == ""{
            self.view.makeToast("제목을 입력하세요.")
            return
        } else if contentTextView.text == textViewPlaceHolder || contentTextView.text?.trimmingCharacters(in: .whitespaces) == ""{
            self.view.makeToast("내용을 입력하세요.")
            return
        }
        var post = Post(date: todayDate, owner: Owner.getOwner(), title: titleTextField.text!, content: contentTextView.text!, like: 0, comments: [])
        postGroup.saveChange(post: post, action: .Add)
        dismiss(animated: true)
    }
    
}

extension PostWriteViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .black
        }
    }
}
