//
//  Comment.swift
//  hanlim-project
//
//  Created by 이정연 on 2023/06/14.
//

import Foundation
import FirebaseFirestore

class ReComment: NSObject , NSCoding{
    var date: Date
    var owner: String?
    var content: String
    var like: Int?
    
    init(date: Date, owner: String?,content: String,like: Int?){
        self.date = Date(timeInterval: 0, since: date)
        self.owner = Owner.getOwner()
        self.content = content
        self.like = like
        super.init()
    }
    
    // archiving할때 호출된다
    func encode(with aCoder: NSCoder) {      // 내부적으로 String의 encode가 호출된다
        aCoder.encode(date, forKey: "date")
        aCoder.encode(owner, forKey: "owner")
        aCoder.encode(content, forKey: "content")
        aCoder.encode(like, forKey: "like")
    }
    // unarchiving할때 호출된다
    required init(coder aDecoder: NSCoder) {
        date = aDecoder.decodeObject(forKey: "date") as! Date
        owner = aDecoder.decodeObject(forKey: "owner") as? String
        content = aDecoder.decodeObject(forKey: "content") as! String? ?? ""
        like = aDecoder.decodeObject(forKey: "like") as? Int
        super.init()
    }
}

extension ReComment{
    convenience init(date: Date? = nil, withData: Bool = false){
        self.init(date: date ?? Date(), owner: "me",content: "",like: 0)
        }
    }

extension ReComment{        // Plan.swift
    func clone() -> ReComment {
        let clonee = ReComment()
        clonee.date = Date(timeInterval: 0, since: self.date) // Date는 struct가 아니라 class이기 때문
        clonee.owner = self.owner
        clonee.content = self.content
        clonee.like = self.like
        return clonee
    }
}

extension ReComment{
    func toDict() -> [String: Any?]{
        var dict: [String: Any?] = [:]
        dict["date"] = Timestamp(date: date)
        dict["owner"] = owner
        dict["content"] = content
        dict["like"] = like
        return dict
    }
    static func toComment (dict: [String: Any?]) -> Comment {
        let comment = Comment()
        comment.date = Date()
        if let timestamp = dict["date"] as? Timestamp{
            comment.date = timestamp.dateValue()
        }
        comment.owner = dict["owner"] as? String
        comment.content = dict["content"] as! String
        comment.like = dict["like"] as? Int
        comment.reComments = dict["reComments"] as? Array<ReComment>
        return comment
    }
}
