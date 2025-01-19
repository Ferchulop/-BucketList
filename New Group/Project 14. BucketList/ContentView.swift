//
//  ContentView.swift
//  Project 14. BucketList
//
//  Created by Fernando Jurado on 9/12/24.
//
import MapKit
import SwiftUI

struct ContentView: View {
    
    // Coordenadas predefinidas para que se muestre al iniciar la app, en este caso Madrid.
    let startPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.4165 , longitude: -3.70256), span: MKCoordinateSpan(latitudeDelta: 6, longitudeDelta: 6)))
    // ViewModel que maneja la lógica de negocio y el estado de la vista.
    @State private var viewModel = ViewModel()
    var body: some View {
        // Envuelvo todo el código en la función de desbloqueo para dar permiso o no y poder visualizar los lugares.
        if viewModel.isUnlocked {
            // MapReader proporciona un proxy para interactuar con las coordenadas y Map renderiza el mapa para poder visualizarlo.
            MapReader { proxy in
                Map(initialPosition: startPosition) {
                    // Añado las anotaciones para cada ubicación.
                    ForEach(viewModel.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(.circle)
                                .onLongPressGesture(minimumDuration: 0.1) {
                                    viewModel.selectedLocation = location
                                }
                        }
                    }
                    
                    
                }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local){
                        viewModel.addLocation(at: coordinate)
                    }
                }
                //Challenge 1: añado modificador para asegurarme que se actualiza correctamente segun lo definido en el viewModel
                .mapStyle(viewModel.mapStyle)
                // CHALLENGE 1:
                HStack(spacing: 80) {
                    Button("Hybrid") {
                        viewModel.mapStyle = .hybrid
                    }
                    
                    Button("Standard") {
                        viewModel.mapStyle = .standard
                    }
                }
                .buttonStyle(.borderedProminent)
                // Detecta toques en el mapa y convierte cada posicion en una coordenada.
            
                // Abro una nueva vista(hoja) para editar la ubicación seleccionada
                .sheet(item: $viewModel.selectedLocation) { place in
                    EditView(location: place) {
                        viewModel.update(location: $0)
                    }
                }
            }
        }else {
            Button("Unlock places") {
                Task {
                    await viewModel.authentication()
                }
            }
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(.capsule)
            .alert("Authentication failed",isPresented: $viewModel.showingError, actions: {
                Button("OK",role: .cancel) {}
            })
        }
    }
}

#Preview {
    ContentView()
}


