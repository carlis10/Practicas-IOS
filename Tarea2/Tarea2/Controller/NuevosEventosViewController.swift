//
//  NuevosEventosViewController.swift
//  Tarea2
//
//  Created by Apps2M on 16/1/23.
//

import UIKit

class NuevosEventosViewController: UIViewController {

    @IBOutlet weak var LoadUI: UIActivityIndicatorView!
    @IBOutlet weak var NuevoEventoTextField: UITextField!
    @IBOutlet weak var DataPicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func send(_ sender: Any) {
        
        // Comprueba que el InputField no este vacío
        if DataManager.ComprobarEvento(evento: NuevoEventoTextField.text!){
            
            // URL para hacer el POST
            let url: String = "https://superapi.netlify.app/api/db/eventos"
            LoadUI.isHidden = false // Aparece el Acitivity indicator
            
            // Recoge la fecha y la transforma a segundos
            let fecha = DataPicker.date
            let dateSeconds = Double(fecha.timeIntervalSince1970)
            
            // Prepara la información recogida
            let parameters: [String: Any] = [
                "date": dateSeconds,
                "name": NuevoEventoTextField.text!
            ]
            
            // Guarda el evento tanto remota como localmente
            DataManager.POST(parametros: parameters, urlString: url)
            DataManager.EventosListData.append(Evento(json: parameters))
            
            // Cierra la pantalla después de un segundo
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                LoadUI.isHidden = true // Oculta el Acitivity indicator
                navigationController?.popToRootViewController(animated: true)
            }
        }
        else {
            NuevoEventoTextField.backgroundColor = UIColor.red
        }
    }
}
