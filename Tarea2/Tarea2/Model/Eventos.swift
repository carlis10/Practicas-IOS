import Foundation

// Crea un evento para poder gestiona la información recibida
class Evento: Decodable{
    var fechaFinal: Double
    var nombre: String
    init(json: [String: Any]){
        fechaFinal = json["date"] as? Double  ?? 0
        nombre = json["name"] as? String ?? ""
    }
    
    // Metodo para diferenciar las fechas basadas en milisegundos, segundos y microsegundos
    static func GestionarFecha(fecha: Double) -> String {
        var fechaseconds: Double = 0
        if fecha > 1000000000000 && fecha < 1000000000000000{
            fechaseconds = fecha/1000
        }
        else if fecha > 1000000000000000{
            fechaseconds = fecha/1000000
        }
        else{
            fechaseconds = fecha
        }
        // Transforma la el numero en segundos a fecha y le da un formato
        let date = Date(timeIntervalSince1970: TimeInterval(fechaseconds))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0100") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
}
