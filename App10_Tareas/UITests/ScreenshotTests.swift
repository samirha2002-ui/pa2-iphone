import XCTest

final class ScreenshotTests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = true
        app.launch()
    }

    func shot(_ name: String) {
        Thread.sleep(forTimeInterval: 1.0)
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    func btn(_ text: String) -> XCUIElement {
        app.buttons.matching(NSPredicate(format: "label CONTAINS[c] %@", text)).firstMatch
    }

    func tap(_ element: XCUIElement) {
        if element.waitForExistence(timeout: 5) { element.tap() }
    }

    func hideKeyboard() {
        let key = app.keyboards.buttons.matching(NSPredicate(format: "label ==[c] %@ OR label ==[c] %@", "return", "done")).firstMatch
        if key.exists { key.tap() }
    }

    func field(_ name: String) -> XCUIElement {
        let f = app.textFields[name]
        return f.waitForExistence(timeout: 3) ? f : app.textViews[name]
    }

    func crear(_ titulo: String, _ detalle: String) {
        tap(btn("Nueva tarea"))
        let t = field("Título"); tap(t); t.typeText(titulo)
        let d = field("Detalle"); tap(d); d.typeText(detalle)
        shot("sheet_nueva_tarea_\(titulo.prefix(3))")
        tap(btn("Guardar"))
    }

    func testCapturas() {
        shot("01_lista_vacia")
        crear("Estudiar SwiftUI", "Repasar NavigationStack y sheets")
        crear("Entregar PA2", "Subir el Word a ISIL+")
        shot("02_lista_con_tareas")
        tap(app.cells.element(boundBy: 0))
        shot("03_sheet_editar_tarea")
        tap(btn("Cancelar"))
        app.cells.element(boundBy: 0).swipeLeft()
        shot("04_deslizar_para_eliminar")
        tap(btn("Eliminar"))
        shot("05_lista_tras_eliminar")
    }
}
