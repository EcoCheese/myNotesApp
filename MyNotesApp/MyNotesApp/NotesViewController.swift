//
//  NotesViewController.swift
//  MyNotesApp
//
//  Created by Илья on 5/14/19.
//  Copyright © 2019 Ilya Kangin. All rights reserved.
//

import UIKit

protocol NoteViewDelegate {
    func didUpdateNoteWithTitle (newTitle: String, andBody newBody: String)
}

class NotesViewController: UIViewController, UITextViewDelegate {
    
    var delegate: NoteViewDelegate?
    var strBodyText: String!
    
    @IBOutlet weak var txtBody : UITextView!
    
    @IBOutlet weak var btnDone: UIBarButtonItem!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction func doneEditingBody(_ sender: Any) {
        self.txtBody.resignFirstResponder()
        
        self.btnDone.tintColor = UIColor.clear
        
        if self.delegate != nil {
            self.delegate!.didUpdateNoteWithTitle(newTitle: self.navigationItem.title! , andBody: self.txtBody.text)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.txtBody.becomeFirstResponder()
        self.txtBody.text = self.strBodyText
        self.txtBody.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView){
        self.btnDone.tintColor = UIColor(red: 0, green: 122.0/255.0, blue: 1, alpha: 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        if self.delegate != nil {
            self.delegate!.didUpdateNoteWithTitle(newTitle: self.navigationItem.title!, andBody: self.txtBody.text)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
