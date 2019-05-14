//
//  ViewController.swift
//  MyNotesApp
//
//  Created by Илья on 5/14/19.
//  Copyright © 2019 Ilya Kangin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, NoteViewDelegate {
    
    func didUpdateNoteWithTitle(newTitle: String, andBody newBody: String) {
        self.arrNotes[self.selectedIndex]["title"] = newTitle
        self.arrNotes[self.selectedIndex]["body"] = newBody
        
        self.tableView.reloadData()
        saveNotesArray()
    }
    
    
    var arrNotes = [[String:String]]()
    var selectedIndex = -1
    
    
    @IBAction func newNote() {
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yy HH:mm"
        let str = format.string(from: Date())
        
        
        let newDict = ["title" : str, "body" : ""]
        
        arrNotes.insert(newDict, at: 0)
        
        self.selectedIndex = 0
        
        self.tableView.reloadData()
        
        saveNotesArray()
        
        performSegue(withIdentifier: "showEditorSegue", sender: nil)
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let newNotes = UserDefaults.standard.array(forKey: "notes") as? [[String:String]]{
            arrNotes = newNotes
        }
        // Do any additional setup after loading the view.
    }
    


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL") as! UITableViewCell
        cell.textLabel!.text = arrNotes[indexPath.row]["title"]
        return cell
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        self.selectedIndex = indexPath.row
        
        performSegue(withIdentifier: "showEditorSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let notesEditorVC = segue.destination as! NotesViewController
        
        
        
        notesEditorVC.navigationItem.title = arrNotes[self.selectedIndex]["title"]
        notesEditorVC.strBodyText = arrNotes[self.selectedIndex]["body"]
        notesEditorVC.delegate = self
    }
    
    func saveNotesArray(){
        UserDefaults.standard.set(arrNotes, forKey: "notes")
        UserDefaults.standard.synchronize()
    }
    
}

