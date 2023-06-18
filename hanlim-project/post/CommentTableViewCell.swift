//
//  CommentTableViewCell.swift
//  hanlim-project
//
//  Created by 이정연 on 2023/06/18.
//

import Foundation
import UIKit

class CommentTableViewCell: UITableViewCell {
    
    var callBackMehtod: (() -> Void)?
    
    // ...
    // Cell 내부의 버튼 IBAction으로 연결
    @IBAction func checkBoxButtonTapped(_ sender: UIButton) {
        callBackMehtod?()
    }
}
