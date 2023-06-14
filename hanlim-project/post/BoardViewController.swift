//
//  BoardViewController.swift
//  hanlim-project
//
//  Created by 이정연 on 2023/06/11.
//

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet weak var postGroupTableView: UITableView!
    
    var postGroup: PostGroup!
    var todayDate: Date? = Date()     // 나중에 필요하다
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postGroupTableView.dataSource = self        // 데이터 소스로 등록
        postGroupTableView.delegate = self        // 딜리게이터로 등록
        
        postGroup = PostGroup(parentNotification: receivingNotification)
        postGroup.queryData()

        
    }
    @IBAction func movePostWriteView(_ sender: UIBarButtonItem) {
        let postWriteVC = self.storyboard?.instantiateViewController(withIdentifier: "PostWriteViewController") as! PostWriteViewController
        self.present(postWriteVC,animated: true,completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        // 여기서 호출하는 이유는 present라는 함수 ViewController의 함수인데 이함수는 ViewController의 Layout이 완료된 이후에만 동작하기 때문
        Owner.loadOwner(sender: self)
    }
    func receivingNotification(post: Post?, action: DbAction?){
        // 데이터가 올때마다 이 함수가 호출되는데 맨 처음에는 기본적으로 add라는 액션으로 데이터가 온다.
        self.postGroupTableView.reloadData()  // 속도를 증가시키기 위해 action에 따라 개별적 코딩도 가능하다.
    }

}

extension BoardViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let postGroup = postGroup{
            return postGroup.getPosts().count
        }
        
        return 0    // planGroup가 생성되기전에 호출될 수도 있다
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //  let cell = UITableViewCell(style: .value1, reuseIdentifier: "")
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell")!
    
        // planGroup는 대략 1개월의 플랜을 가지고 있다.
        let post = postGroup.getPosts()[indexPath.row] // Date를 주지않으면 전체 plan을 가지고 온다

        // 적절히 cell에 데이터를 채움
//        cell.textLabel!.text = plan.date.toStringDateTime()
//        cell.detailTextLabel?.text = plan.content
        

        (cell.contentView.subviews[0] as! UILabel).text = post.title
        (cell.contentView.subviews[1] as! UILabel).text = post.content
        (cell.contentView.subviews[3] as! UILabel).text = "\(post.like!)"
        (cell.contentView.subviews[4] as! UILabel).text = "\(post.comments.count)"
        (cell.contentView.subviews[5] as! UILabel).text = post.owner
        
        (cell.contentView.subviews[7] as! UILabel).text = post.date.toStringDateTime()

        
        return cell
    }
}

extension BoardViewController: UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
                
            let post = self.postGroup.getPosts()[indexPath.row]
                let title = "Delete \(post.title)"
                let message = "Are you sure you want to delete this item?"

                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action:UIAlertAction) -> Void in
                    
                    // 선택된 row의 플랜을 가져온다
                    let post = self.postGroup.getPosts()[indexPath.row]
                    // 단순히 데이터베이스에 지우기만 하면된다. 그러면 꺼꾸로 데이터베이스에서 지워졌음을 알려준다
                    self.postGroup.saveChange(post: post, action: .Delete)
                })
                
                alertController.addAction(cancelAction)
                alertController.addAction(deleteAction)
                present(alertController, animated: true, completion: nil) //여기서 waiting 하지 않는다
            }

    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 40
        }
    }
}

