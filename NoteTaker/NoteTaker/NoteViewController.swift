//
//  NoteViewController.swift
//  NoteTaker
//
//  Created by Teodor Ivanov on 11/25/17.
//  Copyright © 2017 Teodor Ivanov. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var titleNavigationItem: UINavigationItem!
    
    var existingNote: Note?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let note = existingNote {
            titleNavigationItem.title = note.title
            bodyTextView.text = note.body
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        let titleText = titleNavigationItem.title
        let bodyText = bodyTextView.text
        
        var note: Note?
        if let existingNote = existingNote {
            existingNote.title = titleText
            existingNote.body = bodyText
            note = existingNote
        }else {
            note = Note(title: titleText, body: bodyText)
        }
        
        if let note = note{
            do {
                let managedContext = note.managedObjectContext
                try managedContext?.save()
                self.navigationController?.popViewController(animated: true)
            } catch {
                print("Note failed to save")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
