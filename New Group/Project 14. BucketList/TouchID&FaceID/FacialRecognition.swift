//
//  FacialRecognition.swift
//  Project 14. BucketList
//
//  Created by Fernando Jurado on 16/12/24.
//
import LocalAuthentication // framework para hacer uso de los accesos con seguridad
import SwiftUI

struct FacialRecognition: View {
    @State private var isUnlocked = false
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
            
        }
        .onAppear(perform: authentication)
            
    }
    // Funcion para la autenticacion biometrica
    func authentication() {
        let context = LAContext()// Proporciona acceso a las politicas de autenticacion, valida si soporta biometria, ejecuta la autenticacion del usuario, proporciona detalles sobre la autenticacion
        var error: NSError? // Captura errores durante el proceso
        // Se verifica si el dispositivo soporta autenticacion biometrica
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to access your bucket list."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticateError in
                if success {
                    isUnlocked = true
                } else {
                    // Aqui podriamos añadir que si el reconocimiento es fallido pida introducir el PIN para desbloquear el dispositivo
                }
                
            }
        } else {
            
        }
        
    }
}

#Preview {
    FacialRecognition()
}
