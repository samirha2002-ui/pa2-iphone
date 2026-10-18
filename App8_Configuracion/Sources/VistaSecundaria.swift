import SwiftUI

struct VistaSecundaria: View {
    // NO es propietaria: solo recibe una referencia de lectura/escritura
    @Binding var wifiEnabled: Bool
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Toggle("Wi-Fi", isOn: $wifiEnabled)
                Text(wifiEnabled ? "Conectado a la red" : "Sin conexión inalámbrica")
                    .foregroundStyle(.secondary)
            }
            .navigationTitle("Configuración")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Listo") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    VistaSecundaria(wifiEnabled: .constant(true))
}
