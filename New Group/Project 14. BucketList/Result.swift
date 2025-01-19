//
//  Result.swift
//  Project 14. BucketList
//
//  Created by Fernando Jurado on 22/12/24.
//

import Foundation
// Es el punto de entrada principal para decodificar el JSON. El método JSONDecoder().decode(Result.self, from: data) convierte los datos brutos en una instancia de Result en EditView.
struct Result: Codable {
    let query: Query
    
}
// Una vez decodificado el Result, se accede a su propiedad query que contiene las páginas
struct Query: Codable {
    let pages: [Int: Page]
}
// Los valores del diccionario pages en Query son objetos Page. Estas representan cada página con su título, descripción y otros datos.

struct Page: Codable {
    let pageID: Int
    let title: String
    let terms: Terms?
    // Mapeo los datos para poder ser interpretados correctamente por la API
    enum CodingKeys: String, CodingKey {
        case pageID = "pageid"
        case title
        case terms
    }
    // Manejo la descripcion como una cadena para poder mostrar en EditView, si no hay descripcion devuelve "needed.."
    var description: String {
        terms?.description?.first ?? "Needed information"
    }
}



struct Terms: Codable {
    let description: [String]?
}
