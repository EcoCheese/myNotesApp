    //
//  noteTableViewCell.swift
//  myNotes
//
//  Created by Илья on 5/14/19.
//  Copyright © 2019 Ilya Kangin. All rights reserved.
//

import UIKit

class noteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var noteDateTime: UILabel!
    @IBOutlet weak var noteText: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(note: Note){
        let format = DateFormatter()
        format.dateFormat = "dd/mm/yy HH:MM"
        let str = format.string(from: Date())
        
        self.noteDateTime.text = str
        
        self.noteText.text = note.noteText
        
    }
    
}
