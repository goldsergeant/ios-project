//
//  SelectContentViewController.swift
//  ch10-hanlim-stackview
//
//  Created by 이정연 on 2023/05/08.
//

import UIKit

class SelectContentViewController: UIViewController {
    
    @IBOutlet weak var selectContentTableView: UITableView!
    var planDetailViewController : PlanDetailViewController?

    @IBAction func selectContent(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func unselectContent(_ sender: UIButton) {
        planDetailViewController?.contentTextView.text=exContent
        dismiss(animated: true, completion: nil)
    }
    var exContent: String?
    
    
    
    let contents = [
    "엄마 도와 드리기",
    "아르바이트",
    "청소하기",
    "학교 가서 밥먹기",
    "ios 즐겁게 숙제하기",
    "친구와 까페가기",
    "데이트 하기"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 스택뷰 높이 설정
        
        let stackView = view.subviews[0] as! UIStackView
        stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true

        stackView.layer.borderWidth = 1.0
        selectContentTableView.dataSource = self
        selectContentTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        exContent = planDetailViewController?.contentTextView.text
    }
    
}

extension SelectContentViewController: UITableViewDataSource {
    // UITableViewDataSource 프로토콜의 필수 메서드 구현
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return contents.count
       }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "SelectContentViewCell", for: indexPath)
           cell.textLabel?.text = contents[indexPath.row]
           return cell
       }

}

extension SelectContentViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택한 셀의 내용 가져오기
        let selectedContent = contents[indexPath.row]
        
        // PlanDetailViewController의 contextView 내용 변경
        planDetailViewController?.contentTextView.text = selectedContent
    }
}

