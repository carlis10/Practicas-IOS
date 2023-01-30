//
//  CrearCuentaViewController.swift
//  Tarea2
//
//  Created by Apps2M on 1/12/22.
//

import UIKit

class CrearCuentaViewController: UIViewController {

    @IBOutlet weak var nombreInputField: UITextField!
    @IBOutlet weak var contrasenaInputField: UITextField!
    @IBOutlet weak var confirmarInoutField: UITextField!
    override func viewDidLoad() {
        
    }

    // Boton confirmar
    @IBAction func confirmarCuenta(_ sender: Any) {
        // Comprueba que las contraseñas y el nombre esten escritas como se permite
        let ContCorrectas: Bool = GestionarCuentas.comprobarContrasena(contrasena: contrasenaInputField.text!, comprobacion: confirmarInoutField.text!)
        let NombCorrectas: Bool = GestionarCuentas.ComprobarNombre(nombre: nombreInputField.text!)
        
        // Cambia el aspecto de los InputFields para mostrar al usuario si es correcto o no
        if !ContCorrectas{
            contrasenaInputField.backgroundColor = UIColor.red
            confirmarInoutField.backgroundColor = UIColor.red
        } else{
            contrasenaInputField.backgroundColor = UIColor.white
            confirmarInoutField.backgroundColor = UIColor.white
        }
        if !NombCorrectas{
            nombreInputField.backgroundColor = UIColor.red
        }else{
            nombreInputField.backgroundColor = UIColor.white
        }
        
        if NombCorrectas && ContCorrectas{
            
            //URL para la petición POST
            let url:String = "https://superapi.netlify.app/api/register"
            
            // Guarda los parametros deseados
            let parametros: [String:Any] = [
                "user":nombreInputField.text!,
                "pass":contrasenaInputField.text!
            ]
            // Realiza el POST
            DataManager.POST(parametros: parametros, urlString: url)
            // Guarda el usuario activo
            DataManager.UsuarioActivo = Usuario(nombre: nombreInputField.text!, contrasena: contrasenaInputField.text!)
            // Después de un segundo inicia la App si es correcto 
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                if DataManager.Loged{
                    performSegue(withIdentifier: "iniciarApp", sender: sender)
                }
            }
        }
    }

}
