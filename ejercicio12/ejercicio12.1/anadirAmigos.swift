import UIKit

class AnadirAmigos: UIViewController{
    @IBOutlet weak var nombreNuevo: UITextField!
    @IBOutlet weak var afinidadNuevo: UITextField!
    var nombre: String?
    var afinidad: Int?
  
    
    func cambiarColor(CambiarNombre:Bool,CambiarAfinidad:Bool){
        if !CambiarNombre{
            nombreNuevo.backgroundColor = UIColor.red
        }
        if !CambiarAfinidad{
            afinidadNuevo.backgroundColor = UIColor.red
        }
    }
    @IBAction func confirmar(_ sender: Any) {
        var bien1:Bool = false
        var bien2:Bool = false
        afinidad = Int(afinidadNuevo.text!)
        nombre = nombreNuevo.text
        if nombre != ""{
            bien1 = true
            nombreNuevo.backgroundColor = UIColor.white
        }
        if afinidad != nil && afinidad! <= 10 && afinidad! >= 0{
            bien2 = true
            afinidadNuevo.backgroundColor = UIColor.white
        }
        if !bien1 || !bien2{
            cambiarColor(CambiarNombre: bien1,CambiarAfinidad: bien2)
        }
        if bien1 && bien2{
            DataManager.amigo.append(Amigos(nombre: nombre!, afinidad: afinidad!))
            DataManager.saveAmigos()
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
}
