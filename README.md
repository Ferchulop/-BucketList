# BucketList
BucketList es una app **MVVM** desarrollada en SwiftUI que permite a los usuarios almacenar, visualizar y editar detalles de diferentes ubicaciones (puntos de interés, destinos, etc.) que desean visitar o explorar en el futuro.

## Características:

- **Arquitectura MVVM:** La app sigue una arquitectura basada en MVVM (Modelo-Vista-VistaModelo), utilizada para mantener el código bien organizado y separar responsabilidades. **ViewModel** encapsula la lógica de negocio, interactúa con el modelo de datos y se comunica con las vistas teniendo esta una mejor mantenibilidad, escalabilidad y mejor testing.
  
- **MapKit:** Muestra un mapa interactivo con ubicaciones marcadas. El mapa permite a los usuarios añadir nuevas ubicaciones al hacer clic en un punto del mapa. La vista principal "ContentView" integra "MapReader" y "Map" de "MapKit" para proporcionar una experiencia de visualización del mapa y la interacción con las ubicaciones.
  
- **CoreLocation:** Utilizado para manejar la geolocalización del dispositivo, obtener coordenadas precisas y trabajar con ubicaciones específicas. Facilita la integración con "MapKit", ya que se utiliza para agregar nuevas ubicaciones mediante coordenadas.

- **LocalAuthentication:** Proporciona una autenticación biométrica (Face ID, Touch ID, Passcode o Optic ID) que permite desbloquear el acceso a las ubicaciones guardadas. Esto asegura que solo el usuario permitido pueda ver las ubicaciones almacenadas.

- **Uso de Compiler Directives, @escaping:**
 - **Compiler Directives:** Usado para pruebas y depuración, en este caso para evitar cargar en producción datos ficticios o vistas previas innecesarias.

 - **@escaping:** Ideal en operaciones asíncronas, como la función "fetchNearbyPlaces" en la vista de "EditView". Dado que el proceso de red o de carga de datos puede tardar, el "@escaping" permite que "fetchNearbyPlaces" complete su ejecución después de que el código haya salido del alcance de la función que lo llamó.


(🚧 Pendiente de añadir simulación del funcionamiento 🚧)
![Simulator Screen Recording - iPhone 16 Pro - 2025-01-20 at 12 50 22](https://github.com/user-attachments/assets/dd774c70-c47f-4548-80ec-105e278c6b75)
