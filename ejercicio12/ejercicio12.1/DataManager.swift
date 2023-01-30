	import Foundation

class DataManager{
    static var amigo:[Amigos] = []
    static func saveAmigos(){
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(amigo){
            UserDefaults.standard.set(data, forKey: "amigos")
        } else{
            print("Error al guardar los amigos")
        }
    }
    static func loadAmigos(){
        let data = UserDefaults.standard.object(forKey: "amigos")
        if data == nil {
            print("no hay datos guardados")
            saveAmigos()
            return
        }
        let decoder = JSONDecoder()
        if let json = try? decoder.decode([Amigos].self, from: data as! Data){
            amigo = json
        } else{
            print("Error al guardar conciertos")
        }
    }
        
}
