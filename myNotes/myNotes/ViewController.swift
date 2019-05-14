//
//  ViewController.swift
//  myNotes
//
//  Created by Илья on 5/14/19.
//  Copyright © 2019 Ilya Kangin. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var noteTextField: UITextView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if (isExisting == false) {
            let text = noteTextField.text
            
            if let moc = managedObjectContext {
                let note = Note(context: moc)
                
                note.noteText = text
                
                saveToCoreData() {
                    let isInAddMode = self.presentingViewController is UINavigationController
                    
                    if isInAddMode {
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                    else {
                        self.navigationController!.popViewController(animated: true)
                    }
                }
            }
        }
        else if (isExisting == true){
            
            let note = self.note
            let managedObject = note
            managedObject!.setValue(noteTextField.text, forKey: "noteText")
            
            do{
                try context.save()
                
                let isInAddMode = self.presentingViewController is UINavigationController
                
                if isInAddMode {
                    self.dismiss(animated: true, completion: nil)
                }
                
                else {
                    self.navigationController!.popViewController(animated: true)
                }
            }
            
            catch {
                print("Failed to rewrite.")
            }
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem){
        let isInAddMode = presentingViewController is UINavigationController
        
        if isInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController!.popViewController(animated: true)
        }
    }
    
    
    var managedObjectContext: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    var notesFetchedResultsController: NSFetchedResultsController<Note>!
    var notes = [Note]()
    var note: Note?
    var isExisting = false
    var indexPath: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let format = DateFormatter()
        format.dateFormat = "dd/mm/yy HH:MM"
        let str = format.string(from: Date())
        
        dateLabel.text = str
        
        if let note = note {
            
            noteTextField.text = note.noteText
        }
        
        if noteTextField.text != "Enter note..." {
            isExisting = true
            noteTextField.text = ""
        }
        
        
        noteTextField.delegate = self
    }

    func saveToCoreData(completion: @escaping () -> Void){
        managedObjectContext!.perform {
            do {
                try self.managedObjectContext?.save()
                completion()
                print("Note saved.")
            }
            
            catch let error {
                print("Note is not saved: \(error.localizedDescription)")
            }
        }
    }
    
    func textViewEdit(_ textView: UITextView) {
        if (textView.text == "Label"){
            textView.text = ""
        }
    }
}

