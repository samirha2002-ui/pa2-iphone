import SwiftUI

struct VistaPrincipal: View {
    // La vista CREA y es dueña del ViewModel
    @StateObject private var viewModel = CounterViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 28) {
                Text("\(viewModel.count)")
                    .font(.system(size: 90, weight: .bold, design: .rounded))
                    .contentTransition(.numericText())

                HStack(spacing: 16) {
                    Button { viewModel.decrement() } label: {
                        Label("Disminuir", systemImage: "minus.circle.fill")
                    }
                    Button { viewModel.reset() } label: {
                        Label("Reiniciar", systemImage: "arrow.counterclockwise.circle.fill")
                    }
                    Button { viewModel.increment() } label: {
                        Label("Incrementar", systemImage: "plus.circle.fill")
                    }
                }
                .buttonStyle(.bordered)
                .labelStyle(.iconOnly)
                .font(.largeTitle)

                NavigationLink("Ver en la segunda vista") {
                    VistaSecundaria(viewModel: viewModel)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("Contador MVVM")
        }
    }
}

#Preview {
    VistaPrincipal()
}
