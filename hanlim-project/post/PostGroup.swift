//
//  PostGroup.swift
//  hanlim-project
//
//  Created by 이정연 on 2023/06/14.
//

import Foundation

class PostGroup: NSObject{
    var posts = [Post]()            // var plans: [Plan] = []와 동일, 퀴리를 만족하는 plan들만 저장한다.
    var fromDate, toDate: Date?     // queryPlan 함수에서 주어진다.
    var database: PostDatabase!
    var parentNotification: ((Post?, DbAction?) -> Void)?
    
    init(parentNotification: ((Post?, DbAction?) -> Void)? ){
        super.init()
        self.parentNotification = parentNotification
             database = PostDbFirebase(parentNotification: receivingNotification) // 데이터베이스 생성

    }
    func receivingNotification(post: Post?, action: DbAction?){
        // 데이터베이스로부터 메시지를 받고 이를 부모에게 전달한다
        if let post = post{
            switch(action){    // 액션에 따라 적절히     plans에 적용한다
                case .Add: addPost(post: post)
                case .Modify: modifyPost(modifiedPost: post)
                case .Delete: removePost(removedPost: post)
                default: break
            }
        }
        if let parentNotification = parentNotification{
            parentNotification(post, action) // 역시 부모에게 알림내용을 전달한다.
        }
    }
}

extension PostGroup{    // PlanGroup.swift
    
    func queryData(){
        posts.removeAll()    // 새로운 쿼리에 맞는 데이터를 채우기 위해 기존 데이터를 전부 지운다
        
        database.queryPost()
    }
    
    func saveChange(post: Post, action: DbAction){
        // 단순히 데이터베이스에 변경요청을 하고 plans에 대해서는
        // 데이터베이스가 변경알림을 호출하는 receivingNotification에서 적용한다
        database.saveChange(post: post, action: action)
    }
}

extension PostGroup{     // PlanGroup.swift
    func getPosts() -> [Post] {
        
      return posts
    }
}

extension PostGroup{     // PlanGroup.swift
    
    private func count() -> Int{ return posts.count }
    
    
    private func find(_ key: String) -> Int?{
        for i in 0..<posts.count{
            if key == posts[i].key{
                return i
            }
        }
        return nil
    }
}

extension PostGroup{         // PlanGroup.swift
    private func addPost(post:Post){ posts.insert(post, at: 0) }
    private func modifyPost(modifiedPost: Post){
        if let index = find(modifiedPost.key){
            posts[index] = modifiedPost
        }
    }
    private func removePost(removedPost: Post){
        if let index = find(removedPost.key){
            posts.remove(at: index)
        }
    }
}
