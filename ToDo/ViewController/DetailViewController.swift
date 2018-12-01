//
//  DetailViewController.swift
//  ToDo
//
//  Created by Levi Linchenko on 01/12/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var descriptionOutlet: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    var toDoItem: ToDoItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    

    func updateViews(){
        guard let toDoItem = toDoItem else {return}
        titleOutlet.text = toDoItem.title
        descriptionOutlet.text = toDoItem.description
        if toDoItem.isComplete {
            completeButton.setTitle("👊", for: .normal)
        } else {
            completeButton.setTitle("✊", for: .normal)
        }
    }

    
    
    @IBAction func completeTapped(_ sender: Any) {
        guard let toDoItem = toDoItem else {return}
        toDoItem.isComplete = !toDoItem.isComplete
        ToDoController.shared.saveToPersist()
        updateViews()
    }
}
