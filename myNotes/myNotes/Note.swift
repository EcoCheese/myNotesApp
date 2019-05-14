//
//  Note.swift
//  myNotes
//
//  Created by Ilya Kangin on 5/14/19.
//  Copyright © 2019 Ilya Kangin. All rights reserved.
//

import UIKit

class Note {
    
    var dateTime: String
    var noteText: String
    
    init? (dateTime: String, noteText:String){
        
        guard !dateTime.isEmpty else{
            return nil
        }
        
        self.dateTime = dateTime
        self.noteText = noteText
        
    }

}
