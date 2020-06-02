import Foundation

protocol StorageServiceInput {
    func save<T: Encodable>(_ item: T, byKey key: String)
    func get<T: Decodable>(byKey key: String) -> T?
    func delete(byKey key: String)
}

final class StorageService {
    private let storage = UserDefaults.standard
}

extension StorageService: StorageServiceInput {
    func save<T: Encodable>(_ item: T, byKey key: String) {
        guard let encodedItem = try? JSONEncoder().encode(item) else { return }
        storage.set(encodedItem, forKey: key)
        storage.synchronize()
    }
    
    func get<T: Decodable>(byKey key: String) -> T? {
        guard let data = storage.object(forKey: key) as? Data,
            let item = try? JSONDecoder().decode(T.self, from: data)
            else { return nil }
        return item
    }
    
    func delete(byKey key: String) {
        storage.removeObject(forKey: key)
        storage.synchronize()
    }
}
