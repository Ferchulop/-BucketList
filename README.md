# BucketList
BucketList es una app **MVVM** desarrollada en SwiftUI que permite a los usuarios almacenar, visualizar y editar detalles de diferentes ubicaciones (puntos de interés, destinos, etc.) que desean visitar o explorar en el futuro.

## Características:

- **Arquitectura MVVM:** La app sigue una arquitectura basada en MVVM (Modelo-Vista-VistaModelo), utilizada para mantener el código bien organizado y separar responsabilidades. **ViewModel** encapsula la lógica de negocio, interactúa con el modelo de datos y se comunica con las vistas teniendo esta una mejor mantenibilidad, escalabilidad y mejor testing.
- **MapKit:** Muestra un mapa interactivo con ubicaciones marcadas. El mapa permite a los usuarios añadir nuevas ubicaciones al hacer clic en un punto del mapa. La vista principal "ContentView" integra "MapReader" y "Map" de "MapKit" para proporcionar una experiencia de visualización del mapa y la interacción con las ubicaciones.
