//
//  NotesTableViewController.swift
//  NoteTaker
//
//  Created by Teodor Ivanov on 11/25/17.
//  Copyright © 2017 Teodor Ivanov. All rights reserved.
//

import UIKit
import CoreData

class NotesTableViewController: UITableViewController {
    @IBOutlet var notesTableView: UITableView!
    var titleTextField: UITextField?
    
    var notes = [Note]()
    var noteTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        do{
            notes = try managedContext.fetch(fetchRequest)
            notesTableView.reloadData()
        } catch {
            print("Failed to fetch.")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.title
        
        return cell
    }

    @IBAction func addNewTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Add note", message: "Title your note", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField(configurationHandler: titleTextField)
        let createAction = UIAlertAction(title: "Create", style: .default, handler: self.createHandler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(createAction)
        self.present(alertController, animated: true)
    }
    
    func createHandler(alert: UIAlertAction){
        noteTitle = titleTextField?.text
        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "showNote", sender: self)
    }
    
    func titleTextField(textField: UITextField!){
        titleTextField = textField
        titleTextField?.placeholder = "Title of your note"
    }
    
    func deleteNote(at indexPath: IndexPath){
        let note = notes[indexPath.row]
        if let managedContext = note.managedObjectContext {
            managedContext.delete(note)
            do {
                try managedContext.save()
                self.notes.remove(at: indexPath.row)
                notesTableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                print("Delete failed")
                notesTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? NoteViewController else{
            return
        }
        if let selectedRow = notesTableView.indexPathForSelectedRow?.row {
            destination.existingNote = notes[selectedRow]
        }
        if let noteTitle = noteTitle {
            destination.titleNavigationItem.title = noteTitle
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteNote(at: indexPath)
        }
    }
}
