import Foundation

struct Product: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let icon: String          // nombre de un SF Symbol
    let description: String
    let price: Double
}

extension Product {
    static let samples: [Product] = [
        Product(name: "iPhone 15", icon: "iphone",
                description: "Smartphone con chip A16 Bionic, pantalla Super Retina XDR y cámara principal de 48 MP.",
                price: 3799),
        Product(name: "MacBook Air", icon: "laptopcomputer",
                description: "Laptop ultradelgada con chip M2, hasta 18 horas de batería y diseño sin ventilador.",
                price: 4999),
        Product(name: "iPad Air", icon: "ipad",
                description: "Tableta con pantalla Liquid Retina de 10.9 pulgadas, compatible con Apple Pencil.",
                price: 2999),
        Product(name: "Apple Watch", icon: "applewatch",
                description: "Reloj inteligente con monitoreo de salud, GPS y detección de caídas.",
                price: 1599),
        Product(name: "AirPods Pro", icon: "airpodspro",
                description: "Audífonos inalámbricos con cancelación activa de ruido y audio espacial.",
                price: 949),
        Product(name: "Apple TV 4K", icon: "appletv",
                description: "Reproductor multimedia con salida 4K HDR y Dolby Atmos.",
                price: 649),
        Product(name: "HomePod mini", icon: "homepodmini",
                description: "Altavoz inteligente compacto con Siri y control del hogar.",
                price: 399),
        Product(name: "Magic Keyboard", icon: "keyboard",
                description: "Teclado inalámbrico recargable con diseño compacto y Touch ID.",
                price: 549),
        Product(name: "Studio Display", icon: "display",
                description: "Monitor 5K de 27 pulgadas con cámara de 12 MP y sistema de seis altavoces.",
                price: 6499),
        Product(name: "Cargador MagSafe", icon: "bolt.fill",
                description: "Cargador inalámbrico magnético de hasta 15 W para iPhone.",
                price: 169)
    ]
}
