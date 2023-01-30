import Foundation
class Amigos: Codable{
    public let Nombre: String
    public let Afinidad: Int
    init(nombre:String,afinidad:Int){
        Nombre = nombre
        Afinidad = afinidad
    }
    
}
