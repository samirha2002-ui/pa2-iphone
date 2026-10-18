import SwiftUI

struct RegistroView: View {
    // Datos personales
    @State private var nombre = ""
    @State private var correo = ""
    // Credenciales
    @State private var password = ""
    // Preferencias
    @State private var recibirNovedades = true
    @State private var aceptaTerminos = false
    // Control del sheet
    @State private var mostrarExito = false

    private var formularioValido: Bool {
        !nombre.trimmingCharacters(in: .whitespaces).isEmpty
        && correo.contains("@")
        && password.count >= 6
        && aceptaTerminos
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Datos personales") {
                    TextField("Nombre completo", text: $nombre)
                        .textContentType(.name)
                    TextField("Correo electrónico", text: $correo)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }

                Section("Credenciales") {
                    SecureField("Contraseña (mín. 6 caracteres)", text: $password)
                        .textContentType(.newPassword)
                }

                Section("Preferencias") {
                    Toggle("Recibir novedades por correo", isOn: $recibirNovedades)
                    Toggle("Acepto los términos y condiciones", isOn: $aceptaTerminos)
                }

                Section {
                    Button("Registrar") {
                        mostrarExito = true
                    }
                    .frame(maxWidth: .infinity)
                    .disabled(!formularioValido)
                }
            }
            .navigationTitle("Registro de usuario")
            .sheet(isPresented: $mostrarExito) {
                RegistroExitosoView(nombre: nombre)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

struct RegistroExitosoView: View {
    @Environment(\.dismiss) private var dismiss
    let nombre: String

    var body: some View {
        VStack(spacing: 18) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 70))
                .foregroundStyle(.green)
            Text("Registro exitoso")
                .font(.title.bold())
            Text("Bienvenido, \(nombre)")
                .foregroundStyle(.secondary)
            Button("Cerrar") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    RegistroView()
}
