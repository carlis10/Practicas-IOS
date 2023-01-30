//
//  ViewController.swift
//  Ejercicio13
//
//  Created by Apps2M on 29/11/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    @IBOutlet weak var CantantesTableView: UITableView!
    var listaCantantes: [Cantante] = []
    var imagenes: [UIImage] = []
    let url = URL(string: "https://superapi.netlify.app/api/trapi")
    override func viewDidLoad() {
        super.viewDidLoad()
        CantantesTableView.delegate = self
        CantantesTableView.dataSource = self
        URLSession.shared.dataTask(with: url!) {
        (data, response, error) in
        if error == nil {
            do {
                let json = try JSONSerialization.jsonObject(with: data!,options: .mutableContainers)
                self.listaCantantes.removeAll()
                for cantante in json as! [[String : Any]]{
                    self.listaCantantes.append(Cantante(json: cantante))
                }
                DispatchQueue.main.async {
                    self.CantantesTableView.reloadData()
                    for x in self.listaCantantes{
                        let url_img = URL(string:x.pic)
                        do {
                            let data = try Data(contentsOf: url_img!)
                            self.imagenes.append(UIImage(data: data)!)
                            self.CantantesTableView.reloadData()
                        } catch {
                            self.imagenes.append(UIImage(named: "error")!)
                            print("Error al descargar la imagen")
                        }
                        
                    }
                }
            } catch _ {
            print("Error en json")
            }
        } else {
            print("Error en url")
        }
        }.resume()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listaCantantes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cantante Cell", for: indexPath) as! TableViewCell
        celda.Nombre.text = listaCantantes[indexPath.row].name
        celda.Genero.text = listaCantantes[indexPath.row].genre
        if !imagenes.isEmpty{
            celda.Imagen.image = imagenes[indexPath.row]
        }
        
        return celda
    }
}

