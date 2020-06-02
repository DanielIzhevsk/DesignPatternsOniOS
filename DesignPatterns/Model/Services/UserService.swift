import Foundation

protocol UserServiceInput {
    func saveUser(_ user: UserEntity)
    func getAllUsers() -> [UserEntity]
    func getUser(byId userId: String) -> UserEntity?
}

final class UserService {
    private let storageService: StorageServiceInput
    private let allUserKey = "ALL_USER_KEY"
    private var allUserIds: [String] {
        didSet {
            storageService.save(allUserIds, byKey: allUserKey)
        }
    }
    
    init(storageService: StorageServiceInput) {
        self.storageService = storageService
        self.allUserIds = storageService.get(byKey: allUserKey) ?? []
    }
}

extension UserService: UserServiceInput {
    func saveUser(_ user: UserEntity) {
        storageService.save(user, byKey: user.id)
        
        if !allUserIds.contains(user.id) {
            self.allUserIds = allUserIds + [user.id]
        }
    }
    
    func getAllUsers() -> [UserEntity] {
        return self.allUserIds.compactMap { getUser(byId: $0) }
    }
    
    func getUser(byId userId: String) -> UserEntity? {
        return storageService.get(byKey: userId)
    }
}
