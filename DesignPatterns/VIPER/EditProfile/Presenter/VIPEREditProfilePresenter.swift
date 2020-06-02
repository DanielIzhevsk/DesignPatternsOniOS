import Foundation

final class VIPEREditProfilePresenter {
    
    private let userService: UserServiceInput
    private let router: VIPEREditProfileRouterInput
    private weak var view: VIPEREditProfileViewControllerInput?
    
    init(userService: UserServiceInput,
         router: VIPEREditProfileRouterInput,
         view: VIPEREditProfileViewControllerInput) {
        self.userService = userService
        self.router = router
        self.view = view
    }
}

extension VIPEREditProfilePresenter: VIPEREditProfileViewControllerOutput {
    func didTapCloseButton() {
        self.router.closeModule()
    }
    
    func didTapMainButton() {
        guard let userName = self.view?.name, userName.isEmpty == false else { return }
        let newUser = UserEntity(id: UUID().uuidString,
                                 creationDate: Date(),
                                 name: userName)
        self.userService.saveUser(newUser)
        self.router.closeModule()
    }
}
