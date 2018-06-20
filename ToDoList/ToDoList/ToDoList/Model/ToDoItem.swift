//
//  Model.swift
//  ToDoList
//
//  Created by Павел Левищев on 21.04.2018.
//  Copyright © 2018 Pavel Levishchev. All rights reserved.
//

import UIKit

class ToDoItem {

    var name: String
    var isComplete: Bool
    
    var subItems: [ToDoItem]
    
    var subItemsText: String {
        
    if subItems.count == 0 {
        return ""
        }
        
        var completedToDoCount: Int = 0
        for  todo in subItems{
            if todo.isComplete{
                completedToDoCount += 1
            }
        }
        
        if completedToDoCount == 0 {
            return String(subItems.count) + " subItems"
        } else {
            return String(subItems.count) + " subItems  /" +
                    String(completedToDoCount) + " complete"
        }
    }
    
    var countUncompletedSubTask: Int {
        var unCompletedToDoCount: Int = 0
        for  todo in subItems{
            if todo.isComplete{
                unCompletedToDoCount += 1
            }
        }
        return unCompletedToDoCount
    }
    
    init(name: String){
        self.name = name
        self.isComplete = false
        
        self.subItems = []
    }
    
    init(dictionary: NSDictionary) {
        self.name = dictionary.object(forKey: "name") as! String
        
        self.isComplete = dictionary.object(forKey: "isComplete") as! Bool
        self.subItems = []
        
        let arraySubToDo = dictionary.object(forKey: "subtodos") as! NSArray
        
        for subtodoDict in arraySubToDo{
            self.subItems.append(ToDoItem(dictionary: subtodoDict as! NSDictionary))
        }
    }
    
    var dictionary: NSDictionary{
        
        var arraySubToDos = NSArray()
        
        for subItem in subItems {
            arraySubToDos = arraySubToDos.addingObjects(from: [subItem.dictionary as Any]) as NSArray
        }
        
        let dictionary = NSDictionary(objects: [name, isComplete, arraySubToDos],
                                      forKeys: ["name" as NSCopying, "isComplete" as NSCopying, "subtodos" as NSCopying])
        return dictionary
    }
    
    func addSubItem(subItem: ToDoItem){
        subItems.append(subItem)
    }
    
    func removeSubItem(index: Int){
        subItems.remove(at: index)
    }
    
    func changeState()  {
        self.isComplete = !isComplete
    }
    
}
