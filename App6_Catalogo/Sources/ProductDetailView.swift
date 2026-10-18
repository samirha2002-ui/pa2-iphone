import SwiftUI

struct ProductDetailView: View {
    let producto: Product
    @Binding var favoritos: Set<UUID>

    private var esFavorito: Bool { favoritos.contains(producto.id) }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(systemName: producto.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                    .foregroundStyle(.tint)
                    .padding(36)
                    .background(.quaternary, in: RoundedRectangle(cornerRadius: 28))

                Text(producto.name)
                    .font(.largeTitle.bold())

                Text(producto.price, format: .currency(code: "PEN"))
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.green)

                Text(producto.description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .padding()
        }
        .navigationTitle(producto.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if esFavorito {
                        favoritos.remove(producto.id)
                    } else {
                        favoritos.insert(producto.id)
                    }
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: esFavorito ? "heart.fill" : "heart")
                        Text("Favoritos")
                    }
                }
            }
        }
    }
}
