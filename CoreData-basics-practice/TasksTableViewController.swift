//
//  TasksTableViewController.swift
//  CoreData-basics-practice
//
//  Created by Dongwoo Pae on 7/9/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit
import CoreData

class TasksTableViewController: UITableViewController {

    
    //reason we are doing here is because we can connect to tasks variable directly but tableview is not right place for this var tasks to be placed in

    
    //force Unwrapping could be used for json url so we know right away in case the URL is not correct
    //this will fetch everytime this gets called so we can just use lazy var???
    
    /*
     this is a different way of fetching
    var otherTasks: [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()   //generics
        var results = [Task]()
        CoreDataStack.shared.mainContext.performAndWait {
        results = (try? fetchRequest.execute()) ?? []
        }
        return results
    }
     */
    
    var tasks: [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()   //generics
        let results = (try? CoreDataStack.shared.mainContext.fetch(fetchRequest)) ?? []
        return results
    }
    
    func twoHints() {
        let task = tasks[0]
        CoreDataStack.shared.mainContext.delete(task)
        //and make sure you save them
        
        //you need a single tableview delegate - swipe to delete
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)  //whenever tableview appears
            self.tableView.reloadData()
        print(tasks)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")  if you use this then it wont reuse cell it will just create new cells
        cell.textLabel?.text = tasks[indexPath.row].name

        return cell
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            guard let destVC = segue.destination as? TaskDetailViewController,
                let selectedRow = tableView.indexPathForSelectedRow else {return}
                destVC.task = tasks[selectedRow.row]
        }
    }
    //ShowCreateTask segue?? we do not need to use it this time since not that we are using any properties within modelController or updating model object - such as adding a new element(value) to an empty array

}
