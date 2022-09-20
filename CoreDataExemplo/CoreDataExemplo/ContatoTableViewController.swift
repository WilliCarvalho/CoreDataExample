//
//  ContatoTableViewController.swift
//  CoreDataExemplo
//
//  Created by Usuário Convidado on 13/09/22.
//

import UIKit
import CoreData

class ContatoTableViewController: UITableViewController {

    var pessoas: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pessoa")
        
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "nome", ascending: true)]
        
        do {
            pessoas = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Deu ruim: \(error), \(error.userInfo)")
        }
        
        self.tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pessoas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let pessoa = pessoas[indexPath.row]
        
        cell.textLabel?.text = pessoa.value(forKeyPath: "nome") as? String
        cell.detailTextLabel?.text = pessoa.value(forKey: "email" ) as? String
        return cell
    }

    

}
