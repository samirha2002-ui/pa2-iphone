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
        shot("01_principal_wifi_desactivado")
        tap(btn("Abrir configuración"))
        shot("02_sheet_configuracion")
        // Tap en el extremo derecho de la fila, donde esta el interruptor
        let wifi = app.switches.firstMatch
        if wifi.waitForExistence(timeout: 5) {
            wifi.coordinate(withNormalizedOffset: CGVector(dx: 0.93, dy: 0.5)).tap()
        }
        shot("03_sheet_wifi_activado")
        tap(btn("Listo"))
        shot("04_principal_wifi_activado")
    }
}
