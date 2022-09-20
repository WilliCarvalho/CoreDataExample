//
//  ContatoViewController.swift
//  CoreDataExemplo
//
//  Created by Usuário Convidado on 13/09/22.
//

import UIKit
import CoreData

class ContatoViewController: UIViewController {

    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtTelefone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func salvar(_ sender: Any) {
        self.save(name: txtNome.text!, telefone: txtTelefone.text!, email: txtEmail.text!)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func save(name: String, telefone: String, email:String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Pessoa", in: managedContext)!
        
        let pessoa = NSManagedObject(entity: entity, insertInto: managedContext)
        
        pessoa.setValue(name, forKeyPath: "nome")
        pessoa.setValue(telefone, forKeyPath: "telefone")
        pessoa.setValue(email, forKeyPath: "email")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Não foi possível salvar. \(error), \(error.userInfo)")
        }
    }
}
