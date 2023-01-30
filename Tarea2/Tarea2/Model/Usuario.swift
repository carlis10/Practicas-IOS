import Foundation

// Clase para guardar los datos del uusario

class Usuario: Codable{
    var nombre: String
    var contrasena: String
    init(nombre:String,contrasena:String){
        self.nombre = nombre
        self.contrasena = contrasena
    }

}
