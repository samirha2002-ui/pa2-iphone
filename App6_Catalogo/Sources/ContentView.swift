import SwiftUI

struct ContentView: View {
    @State private var favoritos: Set<UUID> = []
    @State private var soloFavoritos = false

    private var productosVisibles: [Product] {
        soloFavoritos
            ? Product.samples.filter { favoritos.contains($0.id) }
            : Product.samples
    }

    var body: some View {
        NavigationStack {
            List(productosVisibles) { producto in
                NavigationLink(value: producto) {
                    HStack(spacing: 14) {
                        Image(systemName: producto.icon)
                            .font(.title2)
                            .frame(width: 36)
                            .foregroundStyle(.tint)
                        Text(producto.name)
                        Spacer()
                        if favoritos.contains(producto.id) {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Catálogo")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: Product.self) { producto in
                ProductDetailView(producto: producto, favoritos: $favoritos)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        soloFavoritos.toggle()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: soloFavoritos ? "heart.fill" : "heart")
                            Text("Favoritos")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
