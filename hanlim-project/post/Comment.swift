//
//  Comment.swift
//  hanlim-project
//
//  Created by 이정연 on 2023/06/14.
//

import Foundation
import FirebaseFirestore

class Comment: NSObject , NSCoding{
    var key: String
    var date: Date
    var owner: String?
    var content: String
    var like: Int?
    var reComments: Array<ReComment> = []
    
    init(date: Date, owner: String?,content: String,like: Int?, reComments: Array<ReComment>){
        self.key = UUID().uuidString
        self.date = Date(timeInterval: 0, since: date)
        self.owner = Owner.getOwner()
        self.content = content
        self.like = like
        self.reComments = reComments
        super.init()
    }
    
    // archiving할때 호출된다
    func encode(with aCoder: NSCoder) {      // 내부적으로 String의 encode가 호출된다
        aCoder.encode(key, forKey: "key")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(owner, forKey: "owner")
        aCoder.encode(content, forKey: "content")
        aCoder.encode(like, forKey: "like")
        aCoder.encode(reComments, forKey: "reComments")
    }
    // unarchiving할때 호출된다
    required init(coder aDecoder: NSCoder) {
        key = aDecoder.decodeObject(forKey: "key") as! String? ?? "" // 내부적으로 String.init가 호출된다
        date = aDecoder.decodeObject(forKey: "date") as! Date
        owner = aDecoder.decodeObject(forKey: "owner") as? String
        content = aDecoder.decodeObject(forKey: "content") as! String? ?? ""
        like = aDecoder.decodeObject(forKey: "like") as? Int
        reComments = aDecoder.decodeObject(forKey: "reComments") as! Array<ReComment>
        super.init()
    }
}

extension Comment{
    convenience init(date: Date? = nil, withData: Bool = false){
        self.init(date: date ?? Date(), owner: "me",content: "",like: 0, reComments: [])
        }
    }

extension Comment{        // Plan.swift
    func clone() -> Comment {
        let clonee = Comment()
        
        clonee.key = self.key    // key는 String이고 String은 struct이다. 따라서 복제가 된다
        clonee.date = Date(timeInterval: 0, since: self.date) // Date는 struct가 아니라 class이기 때문
        clonee.owner = self.owner
        clonee.content = self.content
        clonee.like = self.like
        clonee.reComments = self.reComments
        return clonee
    }
}

extension Comment{
    func toDict() -> [String: Any?]{
        var dict: [String: Any?] = [:]
        
        dict["key"] = key
        dict["date"] = Timestamp(date: date)
        dict["owner"] = owner
        dict["content"] = content
        dict["like"] = like
        dict["ReComments"] = reComments
        return dict
    }
    static func toComment (dict: [String: Any?]) -> Comment {
        let comment = Comment()
        
        comment.key = dict["key"] as! String
        comment.date = Date()
        if let timestamp = dict["date"] as? Timestamp{
            comment.date = timestamp.dateValue()
        }
        comment.owner = dict["owner"] as? String
        comment.content = dict["content"] as! String
        comment.like = dict["like"] as? Int
        comment.reComments = (dict["reComments"] as? Array<ReComment>) ?? []
        return comment
    }
}
