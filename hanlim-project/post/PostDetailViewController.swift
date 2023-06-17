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
    var saveChangeDelegate: ((Post)-> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentTableView.layer.borderWidth = 0.5;
        contentTextView.isEditable = false
        contentTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        commentTableView.delegate = self
        commentTableView.dataSource = self

    }
    
    @IBAction func goToBack(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func pressLikeButton(_ sender: UIButton) {
        print("pressed like")
        if let saveChangeDelegate = saveChangeDelegate{
            post.like!+=1
            likeCountLabel.text = String(post.like!)
            saveChangeDelegate(post)
        }
        
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

extension PostDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell")!
        
        let comment = post.comments[indexPath.row]
        
        (cell.contentView.subviews[0] as! UILabel).text = comment.owner
        (cell.contentView.subviews[2] as! UILabel).text = comment.content
        (cell.contentView.subviews[3] as! UILabel).text = comment.date.toStringDateTime()
        (cell.contentView.subviews[7] as! UILabel).text = String(comment.like!)
        
        return cell
    }
    
    
}

extension PostDetailViewController: UITableViewDelegate{
    
}

extension PostDetailViewController{
    override func viewDidDisappear(_ animated: Bool) {
        if let saveChangeDelegate = saveChangeDelegate{
            saveChangeDelegate(post!)
        }
    }
}
