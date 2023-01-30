import Foundation
import UIKit

class GestionarCuentas{
    
    static func comprobarContrasena(contrasena: String, comprobacion: String) -> Bool{
        return contrasena == comprobacion && contrasena != ""
    }
        
    static func ComprobarNombre(nombre:String) -> Bool{
        return nombre.count >= 4 && nombre.count <= 15
    }

}
