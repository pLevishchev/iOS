//
//  TableViewCell.swift
//  ToDoList
//
//  Created by Павел Левищев on 22.04.2018.
//  Copyright © 2018 Pavel Levishchev. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelSubItems: UILabel!
    @IBOutlet weak var buttonCheck: UIButton!
    
    @IBAction func pushCheckAction(_ sender: Any) {
        todoInCell?.changeState()
        setCheckButton()
        
        saveDate()
    }
    
    var todoInCell: ToDoItem?
    
    func initCell(toDo: ToDoItem){
        todoInCell = toDo
        labelName.text = todoInCell?.name
        labelSubItems.text = todoInCell?.subItemsText
        
        setCheckButton()
    }
    
    func setCheckButton() {
        if todoInCell!.isComplete{
            buttonCheck.setImage(#imageLiteral(resourceName: "checkbox_checked.png"), for: .normal)
        } else {
            buttonCheck.setImage(#imageLiteral(resourceName: "checkbox_unchecked.png"), for: .normal)

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
