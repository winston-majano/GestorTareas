//
//  TaskManager.swift
//  GestorTareas
//
//  Created by winston majano on 3/17/19.
//  Copyright © 2019 whack. All rights reserved.
//

import Foundation
class TaskManager {
    //singleton, solo se crea una instancia de esta clase
    static let sharedInstance = TaskManager()
    
    //array de diccionarios
    var tasks: [[String: String]] = [[String: String]]()
    
    func save(){
        UserDefaults.standard.set(tasks, forKey: "tasks")
    }
    
    
    func load(){
        if let array = UserDefaults.standard.array(forKey: "tasks") as? [[String: String]]{
            tasks = array
        }
    }
    
    
}
