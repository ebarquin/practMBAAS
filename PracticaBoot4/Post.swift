//
//  Post.swift
//  PracticaBoot4
//
//  Created by Eugenio Barquín on 5/4/17.
//  Copyright © 2017 COM. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class Post: NSObject {
    
    var title : String
    var desc: String
    var refInCloud: FIRDatabaseReference?
    var author: String
    
    init(title: String, desc: String, author: String) {
        self.title = title
        self.desc = desc
        self.author = author
        self.refInCloud = nil
        
    }

    init(snap: FIRDataSnapshot?) {
        refInCloud = snap?.ref
        
        desc = (snap?.value as? [String: Any])?["description"] as! String
        title = (snap?.value as? [String: Any])?["title"] as! String
        author = (snap?.value as? [String: Any])?["author"] as! String
        
    }
    

}
