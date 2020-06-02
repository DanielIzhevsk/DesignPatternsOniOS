import Foundation

final class VIPERProfilesPresenter {
    
    struct State {
        var users: [UserEntity]
    }
    
    private weak var view: ViperProfilesViewInput?
    private let userService: UserServiceInput
    private let postService: PostServiceInput
    private let router: VIPERProfilesRouterInput
    
    private var state = State(users: [])
    
    init(userService: UserServiceInput,
         postService: PostServiceInput,
         router: VIPERProfilesRouterInput,
         view: ViperProfilesViewInput) {
        self.userService = userService
        self.postService = postService
        self.router = router
        self.view = view
    }
    
    private func updateUsers() {
        let userDisplayItems = self.state.users
            .map { user -> UserDisplayItem in
                let userPosts = self.postService.getPosts(by: user)
                return UserDisplayItem(user: user,
                                       lastPost: userPosts.max(by: { $0.creationDate < $1.creationDate }),
                                       allPostsCount: userPosts.count) }
        self.view?.showUsers(userDisplayItems)
    }
}

extension VIPERProfilesPresenter: ViperProfilesViewOutput {
    func viewWillAppear() {
        self.view?.title = "Пользователи"
        self.state.users = self.userService.getAllUsers()
        self.updateUsers()
    }
    
    func didSelectProfile(at index: Int) {
        let user = self.state.users[index]
        self.router.showPostsOfUser(user)
    }
    
    func didTapAddButton() {
        self.router.showCreateProfile()
    }
}
