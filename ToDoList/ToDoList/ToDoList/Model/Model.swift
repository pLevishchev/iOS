//
//  Model.swift
//  ToDoList
//
//  Created by Павел Левищев on 21.04.2018.
//  Copyright © 2018 Pavel Levishchev. All rights reserved.
//

import UIKit

var pathForSaveData: String {
    let path  = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "data.plist"
    
    return path
}

var rootItem: ToDoItem?
    
    func loadData() {
        if let dict = NSDictionary(contentsOfFile: pathForSaveData){
            rootItem = ToDoItem(dictionary: dict)
        } else {
            rootItem = ToDoItem(name: "ToDo")
        }
    }
    
    func saveDate(){
        rootItem?.dictionary.write(toFile: pathForSaveData, atomically: true)
}
