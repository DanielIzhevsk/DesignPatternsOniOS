import Foundation

/// Сущность - Пользователь
struct UserEntity {
    /// Идентификатор пользователя
    let id: String
    /// Дата создания пользователя
    let creationDate: Date
    /// Имя пользователя
    var name: String
}

extension UserEntity: Codable {}
