import Foundation
import SwiftData

@Model
final class Task {
    var title: String
    var detail: String
    var createdAt: Date

    init(title: String, detail: String, createdAt: Date = .now) {
        self.title = title
        self.detail = detail
        self.createdAt = createdAt
    }
}
