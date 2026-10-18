import SwiftUI

struct VistaSecundaria: View {
    // El ViewModel viene de fuera: la vista solo lo observa
    @ObservedObject var viewModel: CounterViewModel

    var body: some View {
        VStack(spacing: 16) {
            Text("Valor actual del contador")
                .font(.headline)
            Text("\(viewModel.count)")
                .font(.system(size: 90, weight: .bold, design: .rounded))
                .foregroundStyle(.tint)
        }
        .navigationTitle("Segunda vista")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    VistaSecundaria(viewModel: CounterViewModel())
}
