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
        shot("01_contador_en_cero")
        tap(btn("Incrementar")); tap(btn("Incrementar")); tap(btn("Incrementar"))
        shot("02_contador_incrementado")
        tap(btn("Disminuir"))
        shot("03_contador_disminuido")
        tap(btn("Ver en la segunda vista"))
        shot("04_segunda_vista_mismo_valor")
    }
}
