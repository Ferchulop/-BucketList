//
//  EditView-ViewModel.swift
//  Project 14. BucketList
//
//  Created by Fernando Jurado on 19/1/25.
//

import Foundation

extension EditView {
    
    @Observable
    class ViewModel {
        
        // Defino un grupo de valores relacionados para manejar mas adelante con un condicional los diferentes casos
        enum LoadingState {
            case loading, loaded, failed
        }
        var loadingState = LoadingState.loading
        var pages = [Page]()
        var name: String
        var description: String
        var location: Location
        
        init(location: Location) {
            self.name = location.name
            self.description = location.description
            self.location = location
        }
        
        func save() -> Location {
            /*  Después de asignar variable a la constante id en Location para poder modificarlo, se asigna  un nuevo identificador único a la ubicación. Esto asegura que la nueva instancia sea única,incluso si es similar a una ubicación existente. */
            var newLocation = location
            newLocation.name = name
            newLocation.description = description
            newLocation.id = UUID()
            return newLocation
            
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
}
