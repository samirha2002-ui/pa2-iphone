import SwiftUI
import SwiftData

struct TaskFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    let task: Task?                 // nil = crear, no nil = editar
    @State private var title: String
    @State private var detail: String

    init(task: Task?) {
        self.task = task
        _title  = State(initialValue: task?.title ?? "")
        _detail = State(initialValue: task?.detail ?? "")
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Información de la tarea") {
                    TextField("Título", text: $title)
                    TextField("Detalle", text: $detail, axis: .vertical)
                        .lineLimit(3...6)
                }

                if let task {
                    Section("Registro") {
                        LabeledContent("Creada",
                                       value: task.createdAt.formatted(date: .abbreviated, time: .shortened))
                    }
                }
            }
            .navigationTitle(task == nil ? "Nueva tarea" : "Editar tarea")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") { guardar() }
                        .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }

    private func guardar() {
        if let task {
            task.title = title          // editar: SwiftData detecta el cambio
            task.detail = detail
        } else {
            modelContext.insert(Task(title: title, detail: detail))
        }
        dismiss()
    }
}
