import Foundation

protocol MVVMPostsViewModel {
    var postText: ((String) -> Void)? { get set }
    var userName: ((String) -> Void)? { get set }
    var posts: (([PostDisplayItem]) -> Void)? { get set }
}

final class MVVMPostsViewModelImpementation: MVVMPostsViewModel {
    
    struct State {
        let user: UserEntity
        var currentPostText: String = ""
    }
    
    var postText: ((String) -> Void)?
    var userName: ((String) -> Void)?
    var posts: (([PostDisplayItem]) -> Void)?
    
    private let postService: PostServiceInput
    private weak var view: MVVMPostsView?
    private var state: State

    init(postService: PostServiceInput,
         view: MVVMPostsView,
         user: UserEntity) {
        self.postService = postService
        self.view = view
        self.state = State(user: user)
        self.subscribeToView()
    }
    
    private func subscribeToView() {
        self.subscribeToViewDidLoad()
        self.subscribeToViewWillAppear()
        self.subscribeToCurrentPostText()
        self.subscribeToDidTapAddPostButtonAction()
    }
    
    private func subscribeToViewDidLoad() {
        self.view?.viewDidLoadAciton = { [unowned self] in
            self.updateUserName()
        }
    }
    
    private func subscribeToViewWillAppear() {
        self.view?.viewWillAppearAciton = { [unowned self] in
            self.updatePosts()
        }
    }
    
    private func subscribeToCurrentPostText() {
        self.view?.postText = { [unowned self] text in
            self.state.currentPostText = text
        }
    }
    
    private func subscribeToDidTapAddPostButtonAction() {
        self.view?.didTapAddPostButtonAction = { [unowned self] in
            self.addNewPostIfPossible()
            self.updatePosts()
            self.state.currentPostText = ""
            self.postText?("")
        }
    }
    
    private func updateUserName() {
        self.userName?(self.state.user.name)
    }
    
    private func updatePosts() {
        let posts = self.postService
            .getPosts(by: self.state.user)
            .sorted(by: { $0.creationDate > $1.creationDate })
            .map { PostDisplayItem(post: $0) }
        self.posts?(posts)
    }
    
    private func addNewPostIfPossible() {
        guard self.state.currentPostText.isEmpty == false else { return }
        let post = PostEntity(authorUserId: self.state.user.id,
                              id: UUID().uuidString,
                              creationDate: Date(),
                              text: self.state.currentPostText)
        self.postService.savePost(post)
    }
}
