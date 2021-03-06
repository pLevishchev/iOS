//
//  TableViewController.swift
//  ToDoList
//
//  Created by Павел Левищев on 21.04.2018.
//  Copyright © 2018 Pavel Levishchev. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var toDoItemCurrent: ToDoItem?
    
    @IBAction func pushAddAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Create new item", message: "",
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "ToDo item"
        }
        
        let alertActionCreate = UIAlertAction(title: "Create", style: UIAlertActionStyle.default, handler: { (alertAction) in
            if alert.textFields![0].text != "" {
                let newItem = ToDoItem(name: alert.textFields![0].text!)
                self.toDoItemCurrent?.addSubItem(subItem: newItem)
                self.tableView.reloadData()
                saveDate()
            }
        })
        
        let alertActionCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (alert) in
        })
        
        alert.addAction(alertActionCreate)
        alert.addAction(alertActionCancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if toDoItemCurrent == nil{
            toDoItemCurrent = rootItem
        }
       navigationItem.title = toDoItemCurrent?.name
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self,
                                                                      action: #selector(handleLongPress))
        longPressGestureRecognizer.minimumPressDuration = 1
        tableView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc func handleLongPress(longPress: UILongPressGestureRecognizer){
        let pointOfTouch = longPress.location(in: tableView)
        let indexPath = tableView.indexPathForRow(at: pointOfTouch)
        
        if longPress.state == .began{
            if let indexPath = indexPath{
                let toDoItem = toDoItemCurrent?.subItems[indexPath.row]
                
                let alert = UIAlertController(title: "Edit item", message: "",
                                              preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addTextField { (textField) in
                    textField.placeholder = "ToDo item"
                    textField.text = toDoItem?.name
                }
                
                let alertActionCreate = UIAlertAction(title: "Update", style: UIAlertActionStyle.default, handler: { (alertAction) in
                    if alert.textFields![0].text != "" {
                        toDoItem?.name = alert.textFields![0].text!
                        self.tableView.reloadData()
                        saveDate()
                    }
                })
                
                let alertActionCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (alert) in
                })
                
                alert.addAction(alertActionCreate)
                alert.addAction(alertActionCancel)
                
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDoItemCurrent!.subItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath) as! TableViewCell

        let  itemForCell = toDoItemCurrent!.subItems[indexPath.row]
        
        cell.initCell(toDo: itemForCell)
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            toDoItemCurrent?.removeSubItem(index: indexPath.row)
            saveDate()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let subItem = toDoItemCurrent?.subItems[indexPath.row]
        let tvc = storyboard?.instantiateViewController(withIdentifier: "todoSID")
            as! TableViewController
        
        tvc.toDoItemCurrent = subItem
        
        navigationController?.pushViewController(tvc, animated: true)
    }
 
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
