//
//  WritingData.swift
//  Project 14. BucketList
//
//  Created by Fernando Jurado on 10/12/24.
//

import SwiftUI

struct WritingData: View {
    var body: some View {
        Button("Read and Write") {
            // Conversion de Test Message en datos binarios codificados en UTF-8
            let data = Data("Test Message".utf8)
            // Se genera la URL del archivo al directorio de documentos con el nombre message.txt
            let url = URL.documentsDirectory.appending(path:"message.txt")
            do {
                // Escribe los datos en la url con opciones de seguridad( .atomic: escribe los datos en un archivo temporal, posteriormente al completarse reemplaza al original, .completeFile: opcion para desbloquear el archivo solo cuando el dispositivo ha sido desbloqueado
                try data.write(to:url, options: [.atomic, .completeFileProtection])
                
                let input = try String(contentsOf: url)
                print(input)
            } catch {
                print(error.localizedDescription)
                
            }
        }
    }
}

#Preview {
    WritingData()
}
