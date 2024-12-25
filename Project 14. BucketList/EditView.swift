//
//  EditView.swift
//  Project 14. BucketList
//
//  Created by Fernando Jurado on 21/12/24.
//

import SwiftUI



struct EditView: View {
    // Defino un grupo de valores relacionados para manejar mas adelante con un condicional los diferentes casos
    enum LoadingState {
        case loading, loaded, failed
    }
    // Property wrapper para descartar .sheet en ContentView cada vez que se pulsa el boton guardar.
    @Environment(\.dismiss) var dismiss
    
    var location: Location
    
    @State private var name: String
    @State private var description: String
    var onSave: (Location) -> Void
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place Name", text: $name)
                    TextField("Description", text: $description)
                }
                Section("Nearby...") {
                    switch loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(pages, id: \.pageID) { page in
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
                    var newLocation = location
                    /*  Después de asignar variable a la constante id en Location para poder modificarlo, se asigna  un nuevo identificador único a la ubicación. Esto asegura que la nueva instancia sea única,incluso si es similar a una ubicación existente. */
                    
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await fetchNearbyPlaces()
            }
        }
    }
    // Inicializador para mostar EditView, con @escaping permito que fetchNearbyPlaces complete su ejecución y luego al obtener los datos se ejecute onSave, muy utilizado en operaciones asíncronas.
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave
        // State nos permitirá acceder al wrapper del mismo a mas bajo nivel para poder asignarles un valor inicial
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
        
        
    }
    // Función para mostrar datos de una API con datos relacionados con la ubicación
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
            pages = items.query.pages.values.sorted { $0.title < $1.title }
            loadingState = .loaded
        } catch {
            loadingState = .failed
        }
        
    }
}

#Preview {
    EditView(location: .example) { _ in }
}
