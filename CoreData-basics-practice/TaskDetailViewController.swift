//
//  TaskDetailViewController.swift
//  CoreData-basics-practice
//
//  Created by Dongwoo Pae on 7/9/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit
import CoreData

class TaskDetailViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //if this gets called before outlets exist then the app will crash so you give isViewLoaded to avoid app to be crashed from not having outlets
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        updateViews()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
  /*
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //to make the button enable only you type something as name
        saveButton.isEnabled
        return true
    }
*/
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        //you actually dont need guard below to have this work
        guard let name = nameTextField.text,
            name.isEmpty == false,
            let notes = notesTextView.text else {return}
        
        if let task = task {
            //editing a task
            task.name = name
            task.notes = notes
        } else {
            //creating a task -- adding new value to this data like adding a value/ element to an empty array???
            let newTask = Task(context: CoreDataStack.shared.mainContext)
            newTask.name = name
            newTask.notes = notes
        }
        
        do  {
            try CoreDataStack.shared.mainContext.save()
            navigationController?.popViewController(animated: true)
        } catch {
            print("Failing to save: \(error)")
        }
        
    }
    
    private func updateViews() {
        guard isViewLoaded == true else {return}
        
        if let task = task {
        self.nameTextField.text = task.name
        self.notesTextView.text = task.notes
            self.title = task.name
        } else {
            //create a task
            self.title = "Create Task"
        }
    }
}
