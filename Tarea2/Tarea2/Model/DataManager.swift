import Foundation


class DataManager{
    
    //Usuarios Manager
    
    static var UsuarioActivo: Usuario = Usuario(nombre: "", contrasena: "")
    static var Loged: Bool = false
    
    
    // Eventos Manager
    
    static func ComprobarEvento(evento:String) -> Bool{
        return evento.count >= 2 && evento.count <= 30
    }
    
    // Guarda la lista de eventos localmente
    static var EventosListData:[Evento] = []
    
    // Realiza una petición GET para recibir la lista de eventos
    static func GETEventos(){
        let url = URL(string: "https://superapi.netlify.app/api/db/eventos")
        URLSession.shared.dataTask(with: url!) {
        (data, response, error) in
        if error == nil {
            do {
                // Si se ha realizado correctamente la petición procesa la información recibida
                let json = try JSONSerialization.jsonObject(with: data!,options: .mutableContainers)
                self.EventosListData.removeAll()
                // transforma el Json recibido en un array para separarlo
                for evento in json as! [Any]{
                    //Comprueba el si el tipo de los eventos es el correcto
                    if type(of: evento) != NSNull.self{
                        self.EventosListData.append(Evento(json: evento as! [String:Any]))
                    }
                }
                }
            catch _ {
                print("Error en json")
                }
        } else {
            print("Error en url")
        }
        }.resume()
    }
    
    
    //POST
    
    //Realiza diferentes peticiones POST, cambia dependiendo de la URL
    static func POST(parametros:[String:Any], urlString:String){
        let url = URL(string: urlString)
        
        //Indica que la petición se trata de un POST
        var peticionPOST = URLRequest(url: url!)
        peticionPOST.httpMethod = "POST"

        peticionPOST.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        //Si puede prepara los parametros a enviar, si no puede salta error
        do{
            peticionPOST.httpBody = try JSONSerialization.data(withJSONObject: parametros, options: .prettyPrinted)
            
        }catch{
            print("Error parametos")
        }
        
        // Realiza la petición
        let task = URLSession.shared.dataTask(with: peticionPOST) { data, response, error in
            guard
                let response = response as? HTTPURLResponse,
                error == nil
            else {                                                               // Comrpueba si hay un error de internet
                print("error", error ?? URLError(.badServerResponse))
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {                    // comprueba si hay un error http
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            // Si se trata de un POST relacionado con los usuarios se encarga de gestionarlo de una manera específica
            if let _ = parametros["user"] as? String{
                DispatchQueue.main.async {
                    DataManager.UsuarioActivo.nombre = parametros["user"] as! String
                    DataManager.UsuarioActivo.contrasena = parametros["pass"] as! String
                    DataManager.Loged = true
                }
            }
        }

        task.resume()
    }
    }
    
    
    

