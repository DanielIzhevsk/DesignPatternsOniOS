import Foundation

protocol MVVMProfilesViewModel {
    var users: (([UserDisplayItem]) -> Void)? { get set }
    var title: ((String) -> Void)? { get set }
}

final class MVVMProfilesViewModelImplementation {
    struct State {
        var users: [UserEntity]
    }
    
    private let userService: UserServiceInput
    private let postService: PostServiceInput
    private let router: MVVMProfilesRouterInput
    
    private weak var view: MVVMProfileView?
    private var state: State
    
    var users: (([UserDisplayItem]) -> Void)?
    var title: ((String) -> Void)?
    
    init(view: MVVMProfileView,
         userService: UserServiceInput,
         postService: PostServiceInput,
         router: MVVMProfilesRouterInput) {
        self.view = view
        self.userService = userService
        self.postService = postService
        self.router = router
        self.state = State(users: [])
        self.subscribeToView()
    }
    
    private func subscribeToView() {
        self.subscribeToViewDidLoad()
        self.subscribeToViewWillAppear()
        self.subscribeToDidSelectUser()
        self.subscribeToAddUserButtonTap()
    }
    
    private func subscribeToViewDidLoad() {
        self.view?.viewDidLoadAction = { [unowned self] in
            self.updateTitle()
        }
    }
    
    private func subscribeToViewWillAppear() {
        self.view?.viewWillAppearAction = { [unowned self] in
            self.updateUsers()
            self.updateUserDispayItems()
        }
    }
    
    private func subscribeToDidSelectUser() {
        self.view?.didSelectUserAtIndex = { [unowned self] userIndex in
            let user = self.state.users[userIndex]
            self.router.showPostsOfUser(user)
        }
    }
    
    private func subscribeToAddUserButtonTap() {
        self.view?.didTapAddButtonAction = { [unowned self] in
            self.router.showCreateProfile()
        }
    }
    
    private func updateTitle() {
        self.title?("Пользователи")
    }
    
    private func updateUsers() {
        self.state.users = self.userService.getAllUsers()
    }
    
    private func updateUserDispayItems() {
        let userDisplayItems = self.state.users
            .map { user -> UserDisplayItem in
                let userPosts = self.postService.getPosts(by: user)
                return UserDisplayItem(user: user,
                                       lastPost: userPosts.max(by: { $0.creationDate < $1.creationDate }),
                                       allPostsCount: userPosts.count) }
        self.users?(userDisplayItems)
    }
}

extension MVVMProfilesViewModelImplementation: MVVMProfilesViewModel {
}
