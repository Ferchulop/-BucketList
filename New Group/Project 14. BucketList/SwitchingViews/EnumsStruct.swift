//
//  EnumsStruct.swift
//  Project 14. BucketList
//
//  Created by Fernando Jurado on 10/12/24.
//

import SwiftUI
// Cada una de las vistas a mostrar cuando el estado cambie 
struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed!")
    }
}
// Definimos la vista principal que utiliza un enum para cambiar entre vistas
struct EnumsStruct: View {
    // Enum que representa los posibles estados
    enum LoadingState {
        case loading, success, failed
    }
    @State private var loadingState = LoadingState.loading
    
    var body: some View {
        // Dependiendo del valor de loadingState mostramos una u otra vista
        if loadingState == .loading {
            LoadingView()
        } else if loadingState == .success {
            SuccessView()
        } else if loadingState == .failed {
            FailedView()
        }
    }
}

#Preview {
    EnumsStruct()
}
