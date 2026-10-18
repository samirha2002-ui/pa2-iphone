import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Task.createdAt, order: .reverse) private var tasks: [Task]

    @State private var mostrarNueva = false
    @State private var tareaAEditar: Task?

    var body: some View {
        NavigationStack {
            List {
                ForEach(tasks) { task in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(task.title)
                            .font(.headline)
                        if !task.detail.isEmpty {
                            Text(task.detail)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .lineLimit(2)
                        }
                        Text(task.createdAt.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture { tareaAEditar = task }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            modelContext.delete(task)
                        } label: {
                            Label("Eliminar", systemImage: "trash")
                        }
                    }
                }
            }
            .overlay {
                if tasks.isEmpty {
                    ContentUnavailableView("Sin tareas",
                                           systemImage: "checklist",
                                           description: Text("Toca + para crear una tarea."))
                }
            }
            .navigationTitle("Mis tareas")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        mostrarNueva = true
                    } label: {
                        Label("Nueva tarea", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $mostrarNueva) {
                TaskFormView(task: nil)
            }
            .sheet(item: $tareaAEditar) { task in
                TaskFormView(task: task)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Task.self, inMemory: true)
}
