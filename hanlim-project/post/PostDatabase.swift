//
//  PostDatabase.swift
//  hanlim-project
//
//  Created by 이정연 on 2023/06/14.
//

import Foundation


protocol PostDatabase{
    // 생성자, 데이터베이스에 변경이 생기면 parentNotification를 호출하여 부모에게 알림
    init(parentNotification: ((Post?, DbAction?) -> Void)? )

    func queryPost()

    // 데이터베이스에 plan을 변경하고 parentNotification를 호출하여 부모에게 알림
    func saveChange(post: Post, action: DbAction)
}
