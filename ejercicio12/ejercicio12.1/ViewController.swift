//
//  ViewController.swift
//  Ejercicio12
//
//  Created by Apps2M on 10/11/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var errorEliminar: UILabel!
    @IBOutlet weak var menuOrdenar: UIButton!
    @IBOutlet weak var listaAmigos: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        DataManager.loadAmigos()
        listaAmigos.reloadData()
        listaAmigos.delegate = self
        listaAmigos.dataSource = self
        HacerMenu()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.amigo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda: AmigoCell = tableView.dequeueReusableCell(withIdentifier: "amigo Cell", for: indexPath) as! AmigoCell
        celda.NombreAmigo.text = DataManager.amigo[indexPath.row].Nombre
        celda.AfinidadAmigo.text = String(DataManager.amigo[indexPath.row].Afinidad)
        return celda
        
    }
    func HacerMenu(){
        let mas = UIAction(title: "Descendente") { [self]_ in
            var ordenado:[Amigos] = []
            var numero:Int = 10
            repeat{
                for x in DataManager.amigo{
                    if numero == x.Afinidad{
                        ordenado.append(x)
                    }
                }
                numero -= 1
            } while ordenado.count != DataManager.amigo.count
            DataManager.amigo = ordenado
            listaAmigos.reloadData()
        }
        let menos = UIAction(title: "Ascendente") { [self]_ in
            var ordenado:[Amigos] = []
            var numero:Int = 0
            repeat{
                for x in DataManager.amigo{
                    if numero == x.Afinidad{
                        ordenado.append(x)
                    }
                }
                numero += 1
            } while ordenado.count != DataManager.amigo.count
            DataManager.amigo = ordenado
            listaAmigos.reloadData()
        }
        let menu = UIMenu(title: "Ordenar",children: [mas,menos])
        menuOrdenar.menu = menu
        menuOrdenar.showsMenuAsPrimaryAction = true
    }
    @IBAction func OrdenarPorAfinidad(_ sender: Any) {
        var ordenado:[Amigos] = []
        var numero:Int = 0
        repeat{
            for x in DataManager.amigo{
                if numero == x.Afinidad{
                    ordenado.append(x)
                }
            }
            numero += 1
        } while ordenado.count != DataManager.amigo.count
        DataManager.amigo = ordenado
        listaAmigos.reloadData()
    }
    @IBAction func anadir(_ sender: Any) {
        performSegue(withIdentifier: "irAañadir", sender: sender)
    }
    @IBAction func eliminar(_ sender: Any) {
        if listaAmigos.indexPathForSelectedRow != nil{
            DataManager.amigo.remove(at:listaAmigos.indexPathForSelectedRow!.row)
            listaAmigos.reloadData()
            DataManager.saveAmigos()
        } else{
            errorEliminar.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                self.errorEliminar.isHidden = true
                
            }
        }
        
    }
    
    
}
