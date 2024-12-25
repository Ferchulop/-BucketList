//
//  SwiftUIView.swift
//  Project 14. BucketList
//
//  Created by Fernando Jurado on 10/12/24.
//
import MapKit
import SwiftUI
// Creamos otra struct para almacenar cada una de las anotaciones que queremos, definiendolo con Identifiable para identificarlo de manera unica

struct Location1: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct IntegrationMaps: View {
    // Creamos las localizaciones preestablecidas que queremos que se visualizen
    let locations = [
        Location1(name: "Bernabeu", coordinate: CLLocationCoordinate2D(latitude: 40.453054, longitude: -3.688344)),
        Location1(name: "Palacio Real", coordinate: CLLocationCoordinate2D(latitude: 40.417955, longitude: -3.714312)),
        Location1(name: "El Retiro", coordinate: CLLocationCoordinate2D(latitude: 40.41317, longitude: -3.68307))
    ]
    // Configuro la posicion donde inicia la camara de los mapas, defino su región, el país o lugar con su latitud y longitud y el nivel del zoom con Span
  /*@State private var position = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.4165, longitude: -3.70256 ), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)))*/
    var body: some View {
        // Para darle mas interactividad al mapa, permito que se pueda rotar, hacer zoom y que tenga posibilidad de vista satelite, normal y en 3D
        /*Map(interactionModes: [.rotate, .zoom])
         .mapStyle(.hybrid(elevation: .realistic))*/
        // Si quisiera añadir la posicion con la que inicia añado la constante(let position) con mis coordenadas
        /*Map(initialPosition: position)
         .mapStyle(.hybrid(elevation: .realistic))*/
        // Si esta posicion cambia con el tiempo lo declararé como @State y pasare la propiedad a Binding. Y podremos preconfigurar una serie de botones en la tab para añadir coordenadas preconfiguradas
        VStack {
            // Para conseguir localizaciones exactas con los gestos al tocar en el sitio utilizaremos MapReader
            MapReader { proxy in
                Map()
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            print(coordinate)
                        }
                    }
            }
            
            /*Map {
                ForEach(locations) { location in
                    // Con Marker, añadimos el puntero en forma de globo para señalar cada una de las posiciones
                    //Marker(location.name, coordinate: location.coordinate)
                    // Con Annotation personalizamos la visualizacion de cada una de nuestras posiciones:
                    Annotation(location.name, coordinate: location.coordinate) {
                        Text(location.name)
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding()
                            .background(.blue)
                            .clipShape(.capsule)
                    }
                    // Con AnnotationTitles(.hidden) desaparecerá el mismo nombre que hemos configurado debajo de forma predefinida en Maps
                    .annotationTitles(.hidden)
                    
                }
            } */
            /*Map(position: $position)
                .mapStyle(.hybrid(elevation: .realistic))
                .onMapCameraChange(frequency: .continuous) {context in
                    print(context.region) // Si quisiera informacion en tiempo real de forma continua añadiria un .onMapCameraChange a medida que arrastro o muevo por el mapa
                }
            HStack(spacing: 50) {
                Button("Paris") {
                    position = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)))
                }
                
                Button("Tokio") {
                    position = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.6895, longitude: 139.6917), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)))
                }
            }*/
        }
    }
        
}

#Preview {
    IntegrationMaps()
}
