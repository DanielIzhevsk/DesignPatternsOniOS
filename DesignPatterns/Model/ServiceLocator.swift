import Foundation

struct ServiceLocator {
    private init() {}
    
    private static weak var storageService: StorageService?
    private static func getService() -> StorageServiceInput {
        if let service = Self.storageService { return service }
        let service = StorageService()
        Self.storageService = service
        return service
    }
    
    private static weak var userService: UserService?
    static func getService() -> UserServiceInput {
        if let service = Self.userService { return service }
        let service = UserService(storageService: Self.getService())
        Self.userService = service
        return service
    }
    
    private static weak var postService: PostService?
    static func getService() -> PostServiceInput {
        if let service = Self.postService { return service }
        let service = PostService(storageService: Self.getService())
        Self.postService = service
        return service
    }
}
