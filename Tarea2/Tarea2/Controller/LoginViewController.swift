//
//  LoginViewController.swift
//  Tarea2
//
//  Created by Apps2M on 17/1/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var LoadUI: UIActivityIndicatorView!
    @IBOutlet weak var NombreTextField: UITextField!
    @IBOutlet weak var PassTextField: UITextField!

    @IBAction func IniciarSesion(_ sender: UIButton) {
        // Comprueba que el usuario puede ser correcto
        if GestionarCuentas.ComprobarNombre(nombre: NombreTextField.text!){
            NombreTextField.backgroundColor = UIColor.white
            PassTextField.backgroundColor = UIColor.white
            
            // Prepara la URL y los parametros de la petición
            let url = "https://superapi.netlify.app/api/login"
            let parametros: [String:Any] = [
                "user":NombreTextField.text!,
                "pass":PassTextField.text!
            ]
            DataManager.POST(parametros: parametros, urlString: url)
            LoadUI.isHidden = false
            
            // Después de un segundo comprueba si se ha iniciado sesión
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                // Si se registra pasa de pantalla
                if DataManager.Loged{
                    performSegue(withIdentifier: "iniciarApp", sender: sender)
                    
                }
                // Cambia de color el fondo del texto si el login no es correcto
                else{
                    LoadUI.isHidden = true
                    NombreTextField.backgroundColor = UIColor.red
                    PassTextField.backgroundColor = UIColor.red
                }
            }
        }
        else{
            NombreTextField.backgroundColor = UIColor.red
        }
    }
}

