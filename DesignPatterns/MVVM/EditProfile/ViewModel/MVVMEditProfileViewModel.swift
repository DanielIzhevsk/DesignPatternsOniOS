import Foundation

protocol MVVMEditProfileViewModel {}

final class MVVMEditProfileViewModelImpementation: MVVMEditProfileViewModel {
    
    private weak var view: MVVMEditProfileView?
    private let userService: UserServiceInput
    private let router: MVVMEditProfileRouterInput
    
    private var userName: String = ""
    
    init(view: MVVMEditProfileView,
         userService: UserServiceInput,
         router: MVVMEditProfileRouterInput) {
        self.view = view
        self.userService = userService
        self.router = router
        self.subscribeToView()
    }
    
    private func subscribeToView() {
        self.suscribeToUserName()
        self.subscribeToDidTapMainButton()
        self.subscribeToDidTapCloseButton()
    }
    
    private func suscribeToUserName() {
        self.view?.userName = { [unowned self] userName in
            self.userName = userName
        }
    }
    
    private func subscribeToDidTapMainButton() {
        self.view?.didTapMainButton = { [unowned self] in
            self.createNewUserIfPossible()
            self.router.closeModule()
        }
    }
    
    private func subscribeToDidTapCloseButton() {
        self.view?.didTapCloseButton = { [unowned self] in
            self.router.closeModule()
        }
    }
    
    private func createNewUserIfPossible() {
        guard self.userName.isEmpty == false else { return }
        let newUser = UserEntity(id: UUID().uuidString,
                                 creationDate: Date(),
                                 name: self.userName)
        self.userService.saveUser(newUser)
    }
}
