//
//  PerfilViewController.swift
//  Tarea2
//
//  Created by Apps2M on 1/12/22.
//

import UIKit

class PerfilViewController: UIViewController {

    @IBOutlet weak var nombreTextView: UILabel!
    @IBOutlet weak var PerfilImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        // Enseña el nombre del usuario
        nombreTextView.text = DataManager.UsuarioActivo.nombre
        
        // Añade un borde a la imagen
        PerfilImageView.layer.borderWidth = 2.0
        
    }
    
    @IBAction func ChangeImage(_ sender: Any) {
        // Permite elegir una imagen
        openPHPicker()
    }
    

}
