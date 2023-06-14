//
//  PostWriteViewController.swift
//  hanlim-project
//
//  Created by 이정연 on 2023/06/14.
//

import UIKit

class PostWriteViewController: UIViewController {
    
    let textViewPlaceHolder = "내용을 입력하세요."

    @IBOutlet weak var contentTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentTextView.delegate = self
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
