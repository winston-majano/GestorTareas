//
//  ListViewController.swift
//  GestorTareas
//
//  Created by winston majano on 3/17/19.
//  Copyright © 2019 whack. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    //llamamos la singleton
    var taskManager = TaskManager.sharedInstance

 
    //para rellenar los datos que se muestran en la tabla
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskManager.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as! TaskCell
        
        let task = taskManager.tasks[indexPath.row]
        cell.lblTask.text = task["title"]
        if let image = task["icon"] {
            cell.imgTask.image = UIImage(named: image)
        }else {
             cell.imgTask.image = UIImage(named: "icon-no-icon")
        }
        
        return cell
    }
    
    
   override  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    
    //funcion para agregar tareas
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Nueva Tarea", message: "Nombre de la Tarea", preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: nil)
        
        let alertAction = UIAlertAction(title: "Guardar", style: .default){(alertAction) in
            
            if let textFieldText = alertController.textFields?.first?.text{
                self.taskManager.tasks.append(["title": textFieldText])
                
                //actualizar la tabla despues de agregar el registro
                self.tableView.reloadData()
            }
            
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alertController.addAction(alertAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    //para completar la tarea
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let complete = UITableViewRowAction(style: .normal, title: "Completar"){ (action, indexPath) in
            self.taskManager.tasks.remove(at: indexPath.row)
            
            //para actaliuzar la tabla despues de eliminar el registro
            self.tableView.reloadData()
        }
        
        //marcamos un color de fondo
        complete.backgroundColor = #colorLiteral(red: 0.4980392157, green: 0.5098039216, blue: 0.8509803922, alpha: 1)
        
        return [complete]
    }
    
    
    //metodo para actualizar la vista cuando cambiemos el icono seleccionado en la otra pantalla
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    //pasamos datos de una pantalla a otra
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let destinationVC = segue.destination as! IconsViewController
                
                //recuperamos la tarea seleccionada
                let selectedTask =  taskManager.tasks[indexPath.row]
                
                destinationVC.headerTitleString =  selectedTask["title"]
                destinationVC.selectedTask = indexPath.row
                
            }
        }
    }

    
    
}
