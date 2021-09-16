//
//  Message.swift
//  Flash Chat iOS13
//
//  Created by Evans Owamoyo on 12.08.2021.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Message {
    // message
    let body: String
    
    // email address
    let sender: String
    
    // time sent
    let time: Date?
}

extension Message {
    init(_ firebaseDocument: QueryDocumentSnapshot) {
        body = firebaseDocument.get(K.FStore.bodyField) as! String
        sender = firebaseDocument.get(K.FStore.senderField) as! String
        
        let timeSince1970 = firebaseDocument.get(K.FStore.dateField) as! TimeInterval
        time = Date(timeIntervalSince1970: timeSince1970)
    }
}
