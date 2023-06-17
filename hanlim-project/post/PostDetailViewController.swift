//
//  PostDetailViewController.swift
//  hanlim-project
//
//  Created by 이정연 on 2023/06/16.
//

import UIKit

class PostDetailViewController: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var writeTimeLabel: UILabel!
    
    var post:Post!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentTableView.layer.borderWidth = 0.5;
        contentTextView.isEditable = false
        contentTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true

    }
    
    @IBAction func goToBack(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
}

extension PostDetailViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userNameLabel.text=post.owner
        commentCountLabel.text="\(post.comments.count)"
        contentTextView.text=post.content
        likeCountLabel.text="\(String(post.like!))"
        titleLabel.text=post.title
        writeTimeLabel.text=post.date.toStringDateTime()
        contentTextView.sizeToFit()
    
    }
}
