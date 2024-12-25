//
//  Location.swift
//  Project 14. BucketList
//
//  Created by Fernando Jurado on 19/12/24.
//
import MapKit
import Foundation

// Creo struct con protocolos; Codable: cargar y guardar datos cartograficos, Equatable: encontrar ubicacion concreta en un conjunto de ubicaciones,Identifiable: crear muchos marcadores de ubicacion en nuestro mapa
struct Location: Codable, Identifiable, Equatable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    /*Compiler Directives: 1. Este bloque condicionl protege el codigo de pruebas para  no estar presente en producción ya que example contiene datos ficticios para pruebas o vistas previas. 2. Facilita las pruebas durante el desarrollo al incluir ejemplos rápidos. 3. Mejora la seguridad y eficiencia de la app final.  */
#if DEBUG
    static let example = Location(id: UUID(), name: "Example", description: "Description", latitude: 40.4165, longitude: -3.70256)
#endif
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        
        lhs.id == rhs.id
    }
}
