//
//  CambiarNombreViewController.swift
//  Tarea2
//
//  Created by Apps2M on 2/12/22.
//

import UIKit

class CambiarNombreViewController: UIViewController {

    @IBOutlet weak var NuevoNombre: UITextField!
    
    @IBAction func CambiarNombre(_ sender: Any) {
        // Cambia el nombre de la cuenta si es correcot, si no cambia el color del TextField
        if GestionarCuentas.ComprobarNombre(nombre: NuevoNombre.text!){
            DataManager.UsuarioActivo.nombre = NuevoNombre.text!
            navigationController?.popToRootViewController(animated:true)
        }
        else{
            NuevoNombre.backgroundColor = UIColor.red
        }
    }
    
}
