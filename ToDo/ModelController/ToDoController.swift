//
//  ToDoController.swift
//  ToDo
//
//  Created by Levi Linchenko on 01/12/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import Foundation

class ToDoController {
    
    //Shared instance
    static let shared = ToDoController()
    private init () {
        loadFromPersist()
    }
    
    //Source of truth
    var toDoItems: [ToDoItem] = []
    
    //Crud
    func create(toDoItem: ToDoItem){
        toDoItems.append(toDoItem)
        saveToPersist()
    }
    
    func delete(remove at: Int){
        toDoItems.remove(at: at)
        saveToPersist()
    }
    
    //Persistance
    private let fileURL: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileName = "toDoList.json"
        let finalURL = urls[0].appendingPathComponent(fileName)
        return finalURL
    }()
    
    //Read
    private func loadFromPersist(){
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL)
            let toDoItems = try decoder.decode([ToDoItem].self, from: data)
            self.toDoItems = toDoItems
            
        } catch let error {
            print("Problem loading files from persist \(error)")
        }
    }
    
    //Create
    func saveToPersist(){
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(toDoItems)
            try data.write(to: fileURL)
        } catch let error {
            print("Problem saving files to persist \(error)")
        }
    }
    
    

    
}
