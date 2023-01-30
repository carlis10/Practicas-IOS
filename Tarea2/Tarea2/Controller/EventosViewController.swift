//
//  EventosViewController.swift
//  Tarea2
//
//  Created by Apps2M on 2/12/22.
//

import UIKit

class EventosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var EliminarEventUIButton: UIButton!
    
    @IBOutlet weak var LoadingIU: UIActivityIndicatorView!
    let url = URL(string: "https://superapi.netlify.app/api/db/eventos")
    @IBOutlet weak var eventosTableViewUI: UITableView!
    override func viewDidLoad() {
        // Recoge los eventos
        DataManager.GETEventos()
        
        // Espera un segundo para esperar el tiempo que tarda la petición
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            LoadingIU.isHidden = true
            eventosTableViewUI.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        // actualiza la tablas y desactiva el boton de borrar
        eventosTableViewUI.reloadData()
        EliminarEventUIButton.isEnabled = false
        eventosTableViewUI.dataSource = self
        eventosTableViewUI.delegate = self
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return DataManager.EventosListData.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let celda: EventosTableViewCell = tableView.dequeueReusableCell(withIdentifier: "eventcell", for: indexPath) as! EventosTableViewCell
         celda.NombreCell.text = DataManager.EventosListData[indexPath.row].nombre
         celda.fechaCell.text = Evento.GestionarFecha(fecha: DataManager.EventosListData[indexPath.row].fechaFinal)
         
         return celda
    }
    
    // Comprueba si una celda de la tabla esta selecctionada
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        EliminarEventUIButton.isEnabled = true
    }
    
    @IBAction func Eliminar(_ sender: Any) {
        // borra un evento de forma local
        DataManager.EventosListData.remove(at: eventosTableViewUI.indexPathForSelectedRow!.row)
        eventosTableViewUI.reloadData()
        EliminarEventUIButton.isEnabled = false
        
    }
    @IBAction func Recargar(_ sender: Any) {
        DataManager.EventosListData = []
        eventosTableViewUI.reloadData()
        DataManager.GETEventos()
        LoadingIU.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            LoadingIU.isHidden = true
            eventosTableViewUI.reloadData()
        }
    }
}
