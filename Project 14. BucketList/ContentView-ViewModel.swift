//
//  ContentView-ViewModel.swift
//  Project 14. BucketList
//
//  Created by Fernando Jurado on 24/12/24.
//
import CoreLocation // Framework para obtener la posición geográfica del dispositivo
import Foundation
import LocalAuthentication // Framework para autenticación biometrica Face ID, Touch ID o Optic ID
import MapKit
import _MapKit_SwiftUI
// Encapsulo la lógica del modelo de datos para usar solo dentro de ContentView que contiene una clase ViewModel bajo la macro @Observable para visualizar automaticamente todos los cambios.
extension ContentView {
   @Observable
    
    class ViewModel {
        // CHALLENGE 1:
        var mapStyle: MapStyle = .standard
        // Con private(set) me aseguro de proteger las ubicaciones almacenadas contra escritura directa para evitar ser modificada.
       private(set) var locations: [Location]
       var selectedLocation: Location?
       var isUnlocked = false
       var showingError = false
        // Ruta para guardar las ubicaciones en el sistema de archivos.
        let savePath = URL.documentsDirectory.appending(path: "SavedLocations")
        
        // Inicializador para cargar las ubicaciones desde el almacenamiento local.
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
                
                
            } catch {
                
                locations = []
                
            }
        }
        // Funcion para guardar las ubicaciones.
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Error saving locations")
            }
        }
        // Función para añadir nueva ubicación en un punto específico.
        func addLocation(at point: CLLocationCoordinate2D) {
            
            let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }
        // Función para actualizar una ubicacion existente.
        func update(location: Location) {
            guard let selectedLocation else { return }
            if let index = locations.firstIndex(of: selectedLocation) {
                locations[index] =  location
                save()
            }
            
        }
        
        // Funcion para realizar la autenticación biométrica.
        func authentication() async {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                // CHALLENGE 2:
                do {
                let success = try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason)
                   
                    if success {
                        DispatchQueue.main.async {
                            self.isUnlocked = true
                        }
                    }
                        } catch {
                        DispatchQueue.main.async {
                            self.showingError = true
                                print("error: \(error.localizedDescription)")
                            }
                        }
            } else {
                if let error {
                    DispatchQueue.main.async {
                        self.showingError = true
                        print("error: \(error.localizedDescription)")
                    }
                }
                }
            }
        }
}
 
