//
//  ToDoViewController.swift
//  ToDo
//
//  Created by Levi Linchenko on 01/12/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit

class ToDoViewController: UIViewController, UISearchBarDelegate {
    

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var searchOutlet: UISearchBar!
    
    var searchResults: [ToDoItem] = []
    var isSearching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchOutlet.delegate = self
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        myTableView.reloadData()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText != "" else {isSearching = false; myTableView.reloadData(); return}
        searchResults = ToDoController.shared.toDoItems.filter{$0.title.uppercased().contains(searchText.uppercased())}
        isSearching = true
        myTableView.reloadData()
        
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dest = segue.destination as? DetailViewController,
            let indexPath = myTableView.indexPathForSelectedRow else {return}
        let toDoItem = ToDoController.shared.toDoItems[indexPath.row]
        dest.toDoItem = toDoItem
        
        
    }
 
    
    
    
    
    @IBAction func createTapped(_ sender: Any) {
        presentAlertController()
    }
    
    private func presentAlertController(){
        let alertController = UIAlertController(title: "What awesome task do you want to acomplish?", message: "It's going down", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Task"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Description"
        }
        let save = UIAlertAction(title: "Save", style: .default) { (_) in
            guard let title = alertController.textFields?.first?.text,
                let description = alertController.textFields?[1].text,
                !title.isEmpty else {return}
            let toDo = ToDoItem(title: title)
            toDo.description = description
            ToDoController.shared.create(toDoItem: toDo)
            alertController.dismiss(animated: true, completion: nil)
            self.myTableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancel)
        alertController.addAction(save)
        self.present(alertController, animated: true)
        
    }
    

}

extension ToDoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? searchResults.count : ToDoController.shared.toDoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell"),
            let title = cell.viewWithTag(1) as? UILabel,
            let timeStamp = cell.viewWithTag(2) as? UILabel,
            let complete = cell.viewWithTag(3) as? UILabel else {return UITableViewCell()}
        let toDoItem: ToDoItem!
        if isSearching {
            toDoItem = searchResults[indexPath.row]
        } else {
            toDoItem = ToDoController.shared.toDoItems[indexPath.row]
        }
        
        title.text = toDoItem.title
        timeStamp.text = toDoItem.timeStamp.stringValue()
        if toDoItem.isComplete {
            complete.text = "😎"
        } else {
            complete.text = "😩"
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if isSearching {
                let toDo = searchResults[indexPath.row]
                guard let searchingIndexPath = ToDoController.shared.toDoItems.index(of: toDo) else {return}
                ToDoController.shared.delete(remove: searchingIndexPath)
                searchResults.remove(at: indexPath.row)
            } else {
                ToDoController.shared.delete(remove: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
}
