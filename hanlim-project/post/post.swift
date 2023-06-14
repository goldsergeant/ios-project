//
//  post.swift
//  hanlim-project
//
//  Created by 이정연 on 2023/06/14.
//

import Foundation
import FirebaseFirestore

class Post: NSObject , NSCoding{
    var key: String
    var date: Date
    var owner: String?
    var title: String
    var content: String
    var like: Int?
    var comments: Array<Comment>?
    
    init(date: Date, owner: String?,title: String,content: String,like: Int?, comments: Array<Comment>?){
        self.key = UUID().uuidString
        self.date = Date(timeInterval: 0, since: date)
        self.owner = Owner.getOwner()
        self.title = title
        self.content = content
        self.like = like
        self.comments = comments
        super.init()
    }
    
    // archiving할때 호출된다
    func encode(with aCoder: NSCoder) {      // 내부적으로 String의 encode가 호출된다
        aCoder.encode(key, forKey: "key")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(owner, forKey: "owner")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(content, forKey: "content")
        aCoder.encode(like, forKey: "like")
        aCoder.encode(comments, forKey: "comments")
    }
    // unarchiving할때 호출된다
    required init(coder aDecoder: NSCoder) {
        key = aDecoder.decodeObject(forKey: "key") as! String? ?? "" // 내부적으로 String.init가 호출된다
        date = aDecoder.decodeObject(forKey: "date") as! Date
        owner = aDecoder.decodeObject(forKey: "owner") as? String
        title = aDecoder.decodeObject(forKey: "title") as! String? ?? ""
        content = aDecoder.decodeObject(forKey: "content") as! String? ?? ""
        like = aDecoder.decodeObject(forKey: "like") as? Int
        comments = aDecoder.decodeObject(forKey: "comments") as? Array<Comment>
        super.init()
    }
    
}

extension Post{
    convenience init(date: Date? = nil, withData: Bool = false){
        self.init(date: date ?? Date(), owner: "me",title: "",content: "",like: 0, comments: [])
        }
    }

extension Post{        // Plan.swift
    func clone() -> Post {
        let clonee = Post()
        
        clonee.key = self.key    // key는 String이고 String은 struct이다. 따라서 복제가 된다
        clonee.date = Date(timeInterval: 0, since: self.date) // Date는 struct가 아니라 class이기 때문
        clonee.owner = self.owner
        clonee.title = self.title
        clonee.content = self.content
        clonee.like = self.like
        clonee.comments = self.comments
        return clonee
    }
}

extension Post{
    func toDict() -> [String: Any?]{
        var dict: [String: Any?] = [:]
        
        dict["key"] = key
        dict["date"] = Timestamp(date: date)
        dict["owner"] = owner
        dict["title"] = title
        dict["content"] = content
        dict["like"] = like
        dict["comments"] = comments
        return dict
    }
    static func toPost (dict: [String: Any?]) -> Post {
        let post = Post()
        post.key = dict["key"] as! String
        post.date = Date()
        if let timestamp = dict["date"] as? Timestamp{
            post.date = timestamp.dateValue()
        }
        post.owner = dict["owner"] as? String
        post.title = dict["title"] as! String
        post.content = dict["content"] as! String
        post.like = dict["like"] as? Int
        post.comments = dict["comments"] as? Array<Comment>
        return post
    }
}
