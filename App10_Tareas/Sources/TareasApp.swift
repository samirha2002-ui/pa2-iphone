import SwiftUI
import SwiftData

@main
struct TareasApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Task.self)   // crea el ModelContainer (almacén SQLite)
    }
}
