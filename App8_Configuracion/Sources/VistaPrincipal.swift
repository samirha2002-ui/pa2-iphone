import SwiftUI

struct VistaPrincipal: View {
    // Esta vista es la PROPIETARIA del dato
    @State private var wifiEnabled = false
    @State private var mostrarAjustes = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image(systemName: wifiEnabled ? "wifi" : "wifi.slash")
                    .font(.system(size: 80))
                    .foregroundStyle(wifiEnabled ? .blue : .gray)

                Text("Wi-Fi: \(wifiEnabled ? "Activado" : "Desactivado")")
                    .font(.title2.bold())

                Button("Abrir configuración") {
                    mostrarAjustes = true
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("Principal")
            .sheet(isPresented: $mostrarAjustes) {
                // Se pasa el Binding con el prefijo $
                VistaSecundaria(wifiEnabled: $wifiEnabled)
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    VistaPrincipal()
}
