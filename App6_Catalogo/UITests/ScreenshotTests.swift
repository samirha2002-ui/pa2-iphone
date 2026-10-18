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
        shot("01_lista_catalogo")
        tap(app.cells.element(boundBy: 0))
        shot("02_detalle_producto")
        tap(btn("Favoritos"))
        shot("03_detalle_marcado_favorito")
        tap(app.navigationBars.buttons.element(boundBy: 0))
        shot("04_lista_con_favorito")
        tap(btn("Favoritos"))
        shot("05_lista_filtrada_favoritos")
    }
}
