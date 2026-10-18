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

    func testCapturas() {
        shot("01_formulario_vacio")
        let nombre = app.textFields.element(boundBy: 0)
        tap(nombre); nombre.typeText("Ana Torres")
        hideKeyboard()
        let correo = app.textFields.element(boundBy: 1)
        tap(correo); correo.typeText("ana@correo.com")
        hideKeyboard()
        let clave = app.secureTextFields.firstMatch
        tap(clave); clave.typeText("123456")
        hideKeyboard()
        app.swipeUp()
        tap(app.switches.element(boundBy: 1))
        shot("02_formulario_completo")
        tap(btn("Registrar"))
        shot("03_sheet_registro_exitoso")
    }
}
