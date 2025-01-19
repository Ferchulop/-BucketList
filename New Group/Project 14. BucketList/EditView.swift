//
//  EditView.swift
//  Project 14. BucketList
//
//  Created by Fernando Jurado on 21/12/24.
//

import SwiftUI



struct EditView: View {
  
    // Property wrapper para descartar .sheet en ContentView cada vez que se pulsa el boton guardar.
    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel: ViewModel

    var onSave: (Location) -> Void
   
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place Name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                Section("Nearby...") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageID) { page in
                            Text(page.title)
                                .font(.headline)
                            
                            + Text(": ") +
                            
                            Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later.")
                    }
                    
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    let newLocation = viewModel.save()
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
    // Inicializador para mostar EditView, con @escaping permito que fetchNearbyPlaces complete su ejecución y luego al obtener los datos se ejecute onSave, muy utilizado en operaciones asíncronas.
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
        // State nos permitirá acceder al wrapper del mismo a mas bajo nivel para poder asignarles un valor inicial
        _viewModel = State(initialValue: ViewModel(location: location))
        
        
    }

}

#Preview {
    EditView(location: .example, onSave: { _ in })
}
