import Foundation

protocol PostServiceInput {
    func savePost(_ post: PostEntity)
    func deletePost(_ post: PostEntity)
    func getPosts(by user: UserEntity) -> [PostEntity]
}

final class PostService {
    private let storageService: StorageServiceInput
    private let postsByUserKey = "POSTS_BY_USER"
    private var postsByUser: [String: [PostEntity]] {
        didSet {
            storageService.save(postsByUser, byKey: postsByUserKey)
        }
    }
    
    init(storageService: StorageServiceInput) {
        self.storageService = storageService
        self.postsByUser = storageService.get(byKey: postsByUserKey) ?? [:]
    }
}

extension PostService: PostServiceInput {
    func savePost(_ post: PostEntity) {
        storageService.save(post, byKey: post.id)
        
        if let posts = postsByUser[post.authorUserId] {
            let updatedPosts = posts.filter { $0.id != post.id } + [post]
            postsByUser[post.authorUserId] = updatedPosts
        } else {
            postsByUser[post.authorUserId] = [post]
        }
    }
    
    func deletePost(_ post: PostEntity) {
        storageService.delete(byKey: post.id)
        
        if let posts = postsByUser[post.authorUserId] {
            let updatedPosts = posts.filter { $0.id != post.id }
            postsByUser[post.authorUserId] = updatedPosts
        }
    }
    
    func getPosts(by user: UserEntity) -> [PostEntity] {
        return postsByUser[user.id] ?? []
    }
}
