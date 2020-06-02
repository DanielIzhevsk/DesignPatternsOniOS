import Foundation

/// Сущность Пост
struct PostEntity {
    /// Идентификатор пользователя, который создал пост
    let authorUserId: String
    /// Идентификатор поста
    let id: String
    /// Дата создания поста
    let creationDate: Date
    /// Текст поста
    let text: String
}

extension PostEntity: Codable {}
