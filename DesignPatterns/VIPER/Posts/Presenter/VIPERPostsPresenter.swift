import Foundation

final class VIPERPostsPresenter {
    
    struct State {
        let user: UserEntity
    }
    
    private let postsService: PostServiceInput
    private weak var view: VIPERPostsViewInput?
    private var state: State
    
    init(postsService: PostServiceInput,
         view: VIPERPostsViewInput,
         user: UserEntity) {
        self.postsService = postsService
        self.view = view
        self.state = State(user: user)
    }
    
    private func updatePosts() {
        let posts = self.postsService
            .getPosts(by: self.state.user)
            .sorted(by: { $0.creationDate > $1.creationDate })
            .map { PostDisplayItem(post: $0) }
        self.view?.updatePosts(posts)
    }
    
    private func addNewPostIfPossible() {
        guard let postText = self.view?.postText,
            postText.isEmpty == false else { return }
        let post = PostEntity(authorUserId: self.state.user.id,
                              id: UUID().uuidString,
                              creationDate: Date(),
                              text: postText)
        self.postsService.savePost(post)
    }
}

extension VIPERPostsPresenter: VIPERPostsViewOutput {
    func viewDidLoad() {
        self.view?.setUserName(self.state.user.name)
    }
    
    func viewWillAppear() {
        self.updatePosts()
    }
    
    func didTapAddPostButton() {
        self.addNewPostIfPossible()
        self.updatePosts()
        self.view?.postText = ""
    }
}
